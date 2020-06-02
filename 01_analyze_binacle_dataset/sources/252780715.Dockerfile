FROM alpine:3.6  
  
RUN apk update \--no-cache \  
&& apk add \--no-cache \  
make \  
g++ \  
tcl-dev \  
expect \  
apache2-dev \  
apache2 \  
&& mkdir /run/apache2 \  
&& wget http://mirrors.sonic.net/apache/tcl/rivet/rivet-2.3.4.tar.gz \  
&& tar -zxvf rivet*.tar.gz \  
&& cd /rivet-2.3.4 \  
&& ./configure --with-tcl=/usr/lib/ --with-tclsh=/usr/bin/tclsh8.6 \  
&& make \  
&& make install \  
&& apk del make g++ \  
&& rm -rf /var/cache/apk/*  
  
EXPOSE 80  
  
CMD ["/usr/sbin/httpd", "-f", "/etc/apache2/httpd.conf", "-DFOREGROUND"]  

