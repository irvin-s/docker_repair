FROM nginx:1

RUN apt-get update && apt-get install -y \
    iptables \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY doc /usr/share/nginx/html/doc/
COPY static /usr/share/nginx/html/static/
COPY webserver/nginx.conf /etc/nginx/nginx.template
COPY docker/configure_nginx.sh /usr/local/bin/
COPY docker/cert.pem docker/key.pem /etc/nginx/ssl/

EXPOSE 80 443

# "configure_nginx.sh" tries to find an SSL certificate and a private
# key at /run/secrets/cert.pem and /run/secrets/key.pem. Only if they
# are not found there, it falls back to a self-signed certificate.
ENTRYPOINT ["configure_nginx.sh"]

CMD ["nginx", "-g", "daemon off;"]

################################################################################

# Set this to the name and the port of the web server to which the
# requests will be forwarded.
ENV PROXY_PASS_TO web:8000

# Set this to your site domain name.
ENV CMBARTER_HOST localhost
