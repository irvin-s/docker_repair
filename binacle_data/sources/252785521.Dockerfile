FROM combro2k/alpine-base:latest  
  
LABEL org.label-schema.build-date=$BUILD_DATE \  
org.label-schema.vcs-ref=$VCS_REF \  
org.label-schema.vcs-url=$VCS_URL \  
org.label-scheme.dockerfile=$DOCKERFILE  
  
RUN \  
apk --quiet --no-cache add nodejs nodejs-npm curl tar && mkdir -p /app && \  
apk del \--quiet --no-cache --purge && rm -rf /var/cache/apk/*  

