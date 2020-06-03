FROM alpine:3.7  
RUN apk add -U --no-cache stunnel gettext \  
&& rm /etc/stunnel/stunnel.conf  
  
ADD entrypoint /entrypoint  
ADD stunnel.conf.tmpl /etc/stunnel/stunnel.conf.tmpl  
  
ENTRYPOINT ["/entrypoint", "/usr/bin/stunnel"]  
CMD ["/etc/stunnel/stunnel.conf"]  

