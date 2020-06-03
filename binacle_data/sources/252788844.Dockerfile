FROM gliderlabs/registrator:v7  
MAINTAINER David Hallum <david@driveclutch.com>  
  
COPY ecs_entrypoint.sh /  
  
RUN apk --update add \  
curl && \  
rm -rf /var/cache/apk/* /tmp/*  
  
ENV RESYNC_SECONDS 10  
ENTRYPOINT "/ecs_entrypoint.sh"  

