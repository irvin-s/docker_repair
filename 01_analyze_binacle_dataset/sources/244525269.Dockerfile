FROM mhrivnak/pulp-k8s-base:f26

EXPOSE 80 443

RUN rm /etc/pki/tls/certs/localhost.crt && ln -s /var/run/secrets/pulp/httpd-certs/httpd.crt /etc/pki/tls/certs/localhost.crt
RUN rm /etc/pki/tls/private/localhost.key && ln -s /var/run/secrets/pulp/httpd-certs/httpd.key /etc/pki/tls/private/localhost.key

RUN rm /etc/pki/pulp/ca.crt && ln -s /var/run/secrets/pulp/httpd-certs/auth-ca.crt /etc/pki/pulp/ca.crt
RUN rm /etc/pki/pulp/ca.key && ln -s /var/run/secrets/pulp/httpd-certs/auth-ca.key /etc/pki/pulp/ca.key

RUN mkdir -p /var/run/secrets/pulp/httpd-certs && chmod 700 /var/run/secrets/pulp/httpd-certs && chown apache /var/run/secrets/pulp/httpd-certs
