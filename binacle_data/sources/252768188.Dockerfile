FROM alpine  
MAINTAINER tescom <tescom@atdt01410.com>  
  
RUN apk add --update build-base \  
perl \  
python \  
python-dev \  
openssl \  
&& wget -O- https://bootstrap.pypa.io/get-pip.py | python \  
&& pip install twisted \  
&& apk del --purge build-base \  
python-dev \  
openssl \  
&& rm -rf /var/cache/apk/*  
  
ENV MAIL_NAME mydomain.com  
ENV MAIL_PATH /tmp/mail  
ENV MAIL_USER admin  
ENV MAIL_PASS admin  
ENV MAIL_OPTS=  
  
VOLUME /tmp/mail  
EXPOSE 25 110  
CMD twistd -n mail --smtp=tcp:25 \  
\--pop3=tcp:110 \  
\--maildirdbmdomain=$MAIL_NAME=$MAIL_PATH \  
\--user=$MAIL_USER=$MAIL_PASS \  
\--bounce-to-postmaster \  
$MAIL_OPTS  

