FROM abiosoft/caddy:builder  
ENV VERSION=0.10.12  
ENV PLUGINS=jwt  
RUN /bin/sh /usr/bin/builder.sh  
  
FROM alpine:3.7  
COPY \--from=0 /install/caddy /usr/bin/caddy  
RUN apk add --update --no-cache \  
openssh-client \  
libcap \  
&& setcap 'cap_net_bind_service=+ep' /usr/bin/caddy \  
&& apk del libcap \  
&& addgroup -S -g 8888 caddy \  
&& adduser -S -u 8888 -D -H caddy \  
&& mkdir -p \  
/etc/proxy \  
/etc/proxy.d \  
&& chown -R caddy:caddy \  
/srv \  
/etc/proxy \  
/etc/proxy.d  
COPY Caddyfile /etc/proxy/Caddyfile  
RUN chown caddy /etc/proxy/Caddyfile  
RUN apk add --no-cache ca-certificates  
USER caddy  
ENV ORIGIN="web:3000"  
ENV CADDYPATH="/etc/proxy"  
ENV TLS="self_signed"  
VOLUME /etc/proxy  
VOLUME /etc/proxy.d  
EXPOSE 80 443 2015  
CMD ["/usr/bin/caddy", "--conf", "/etc/proxy/Caddyfile", "--log", "stdout"]  

