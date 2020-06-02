# See following page to find out CRS version
# https://github.com/SpiderLabs/owasp-modsecurity-crs/blob/v3.0/master/CHANGES
#
# docker build -t fareoffice/modsecurity:v3-nginx-crs-<CRS-VERSION> .
# docker push fareoffice/modsecurity:v3-nginx-crs-<CRS-VERSION>

FROM owasp/modsecurity:v3-ubuntu-nginx

ENV CRS_PATH=/etc/nginx/modsecurity.d/owasp-crs

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get -y install python git ca-certificates

WORKDIR /etc/nginx/modsecurity.d

# Checking out by git sha to get version 3.0.2 of CRS
# See https://github.com/SpiderLabs/owasp-modsecurity-crs/releases/tag/v3.0.2
RUN \
  git clone -b v3.0/master --single-branch https://github.com/SpiderLabs/owasp-modsecurity-crs owasp-crs && \
  cd owasp-crs && \
  git checkout e4e0497be4d598cce0e0a8fef20d1f1e5578c8d0 && \
  rm -rf .git util/regression-tests

RUN \
  mv owasp-crs/crs-setup.conf.example owasp-crs/crs-setup.conf && \
  mv owasp-crs/rules/REQUEST-900-EXCLUSION-RULES-BEFORE-CRS.conf.example owasp-crs/rules/REQUEST-900-EXCLUSION-RULES-BEFORE-CRS.conf && \
  mv owasp-crs/rules/RESPONSE-999-EXCLUSION-RULES-AFTER-CRS.conf.example owasp-crs/rules/RESPONSE-999-EXCLUSION-RULES-AFTER-CRS.conf

# Need this to make for loop work correctly in the next RUN block
SHELL ["/bin/bash", "-c"]

# REQUEST-903 is Drupal and Wordpress specific
RUN \
  sed -i -e 's/SecRuleEngine DetectionOnly/SecRuleEngine On/g' modsecurity.conf && \
  printf "\ninclude owasp-crs/crs-setup.conf\n" >> include.conf && \
  for i in `ls -v owasp-crs/rules/*.conf`; do if [[ $i != *"REQUEST-903"* ]]; then printf "include $i\n" >> include.conf; fi done;

COPY *.sh /
RUN chmod u+x /*.sh

COPY nginx.conf /etc/nginx/

# Logs to stdout/stderr
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
  ln -sf /dev/stderr /var/log/nginx/error.log && \
  ln -sf /dev/stdout /var/log/modsec_audit.log

RUN /cleanup.sh && rm -f /cleanup.sh

# ----------------------------------------------------------------------------

# https://github.com/SpiderLabs/owasp-modsecurity-crs/blob/v3.0/master/crs-setup.conf.example#L130
# - A paranoia level of 1 is default. In this level, most core rules
#   are enabled. PL1 is advised for beginners, installations
#   covering many different sites and applications, and for setups
#   with standard security requirements.
#   At PL1 you should face FPs rarely. If you encounter FPs, please
#   open an issue on the CRS GitHub site and don't forget to attach your
#   complete Audit Log record for the request with the issue.
# - Paranoia level 2 includes many extra rules, for instance enabling
#   many regexp-based SQL and XSS injection protections, and adding
#   extra keywords checked for code injections. PL2 is advised
#   for moderate to experienced users desiring more complete coverage
#   and for installations with elevated security requirements.
#   PL2 comes with some FPs which you need to handle.
# - Paranoia level 3 enables more rules and keyword lists, and tweaks
#   limits on special characters used. PL3 is aimed at users experienced
#   at the handling of FPs and at installations with a high security
#   requirement.
# - Paranoia level 4 further restricts special characters.
#   The highest level is advised for experienced users protecting
#   installations with very high security requirements. Running PL4 will
#   likely produce a very high number of FPs which have to be
#   treated before the site can go productive.
ENV PARANOIA=3

# Possible values: On, Off, DetectionOnly
ENV SEC_RULE_ENGINE=On

# https://github.com/SpiderLabs/owasp-modsecurity-crs/issues/656
# The default values for the PCRE Match limit are very, very low with ModSecurity.
# You can got to 500K usually without harming your set.
# But for your information:
# The PCRE Match limit is meant to reduce the chance for a DoS attack via
# Regular Expressions. So by raising the limit you raise your vulnerability in this regard,
# but the PCRE errors are much worse from a security perspective. I run with 500K in prod usually.
ENV SEC_PRCE_MATCH_LIMIT=500000
ENV SEC_PRCE_MATCH_LIMIT_RECURSION=500000

# Keycloak proxy most probably in our case, hence port 3000
ENV PROXY_UPSTREAM_HOST=localhost:3000

# Allow to congifure client_max_body_size to avoid a HTTP 413
ENV CLIENT_MAX_BODY_SIZE=1m

# Avoid clickjacking attacks, by ensuring that content is not embedded into other sites.
# Possible values: DENY, SAMEORIGIN, ALLOW-FROM https://example.com/
# Remove this header with values: Off, No or an empty string
ENV PROXY_HEADER_X_FRAME_OPTIONS=SAMEORIGIN

EXPOSE 80

ENTRYPOINT ["/main.sh"]
CMD /usr/local/nginx/nginx -g "daemon off;"
