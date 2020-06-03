# Use official Alpine release  
FROM alpine:latest as build  
  
# Maintainer  
LABEL maintainer="Björn Gernert <mail@bjoern-gernert.de>"  
  
ENV RADSECURL https://software.nordu.net/radsecproxy/  
ENV RADSECFILENAME radsecproxy-1.6.9.tar.xz  
  
# Change woring dir  
WORKDIR /root  
  
# Update apk  
RUN apk update  
  
# Install buildtools  
RUN apk add --no-cache make g++ openssl-dev  
  
# Create output dir  
RUN mkdir output  
  
# Download Radsecproxy source files  
RUN wget ${RADSECURL}${RADSECFILENAME}  
  
# Untar Radsecproxy  
RUN tar xf ${RADSECFILENAME} \--strip-components=1  
  
# Configure  
RUN ./configure --prefix=/root/output --sysconfdir=/etc  
  
# Make and install to output dir  
RUN make && make install  
  
# --- --- ---  
# Create Radsecproxy container  
FROM alpine:latest  
  
# Update apk  
RUN apk update  
  
# Install openssl and tini  
RUN apk add --no-cache openssl tini  
  
# Copy from 'build' stage  
COPY \--from=build /root/output/ /  
COPY \--from=build /root/radsecproxy.conf-example /etc/radsecproxy.conf  
  
# Create Radsecproxy logging and certs dir  
RUN mkdir /var/log/radsecproxy  
RUN mkdir -p /etc/radsecproxy/certs  
  
# Export volumes  
VOLUME /var/log/radsecproxy  
  
# Make Radsecproxy's ports available  
EXPOSE 1812  
EXPOSE 1813  
# Set Tini entrypoint  
ENTRYPOINT ["/sbin/tini", "--"]  
  
# Start Radsecproxy  
CMD ["/sbin/radsecproxy", "-f", "-c", "/etc/radsecproxy.conf"]

