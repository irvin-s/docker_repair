FROM httpd
RUN mkdir -p $HTTPD_PREFIX/htdocs/hello
COPY hello/* $HTTPD_PREFIX/htdocs/hello

