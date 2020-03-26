FROM alpine:3.7  
MAINTAINER ancolin  
  
ENV PGDATA=/var/lib/postgresql/data  
  
RUN apk update \  
&& apk upgrade \  
&& apk add \  
postgresql \  
tzdata \  
&& cp /usr/share/zoneinfo/Japan /etc/localtime \  
&& apk del tzdata \  
&& rm -rf /var/cache/apk/* \  
&& echo "export PGDATA=${PGDATA}" > /etc/profile.d/postgresql.sh \  
&& mkdir -p /run/postgresql \  
&& chown postgres:postgres /run/postgresql  
  
COPY entrypoint.sh /usr/bin/  
RUN chmod a+x /usr/bin/entrypoint.sh  
  
USER postgres  
ENTRYPOINT ["entrypoint.sh"]  
CMD ["app:start"]  

