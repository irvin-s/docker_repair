FROM cogentwebs/base  
  
MAINTAINER Pichate Ins <cogent@cogentwebworks.com>  
  
# Set labels  
LABEL com.posgresql.cogentwebworks.version="0.1.0-beta"  
  
ENV POSTGRES_DB=docker_db  
ENV POSTGRES_USER=user_db  
ENV POSTGRES_PASSWORD=password_db  
ENV LANG=en_US.utf8  
ENV PGDATA=/var/lib/postgresql/data  
ENV PG_TRUST_LOCALNET=true  
ENV PG_MAJOR=10  
ENV PG_VERSION=10.1  
ENV PG_SHA256=3ccb4e25fe7a7ea6308dea103cac202963e6b746697366d72ec2900449a5e713  
  
### Files Addition  
ADD rootfs /  
  
### Build Postgresql  
RUN apk-install postgresql su-exec && apk-clean  
  
## VOLUME  
VOLUME ["/var/lib/postgresql/data"]  
  
## Networking Configuration  
EXPOSE 5432  
### Entrypoint Configuration  
ENTRYPOINT ["/init"]  

