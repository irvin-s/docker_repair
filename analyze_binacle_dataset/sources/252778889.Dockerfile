FROM node:6-alpine  
MAINTAINER JD Courtoy <jd.courtoy@gmail.com>  
  
RUN addgroup app && adduser -D -G app -s /bin/false app  
  
ENV GHOST_SOURCE /usr/src/app  
ENV GHOST_CONTENT /var/lib/ghost  
ENV GHOST_VERSION 0.11.10  
WORKDIR $GHOST_SOURCE  
VOLUME $GHOST_CONTENT  
  
COPY build.sh /build.sh  
RUN chmod 755 /build.sh  
RUN /build.sh  
  
COPY ./entrypoint.sh /  
ENTRYPOINT [ "/sbin/tini", "--", "/entrypoint.sh" ]  
  
EXPOSE 2368  
CMD [ "npm", "start" ]  

