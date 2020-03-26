FROM progrium/busybox

# Add the binary
ADD package-proxy-linux-amd64 /package-proxy
RUN chmod +x /package-proxy

# Add a CA bundle
ADD ca-bundle.crt /etc/ssl/ca-bundle.pem

# Setup a certs dir for generated certs
RUN mkdir /certs

EXPOSE 3142 3143
CMD ["/package-proxy","-dir","/tmp/cache","-tls"]