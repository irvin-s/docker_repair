FROM alpine:3.4  
  
ARG BRANCH  
ARG COMMIT  
ARG DATE  
ARG URL  
ARG VERSION  
ARG REV  
ARG DOCKER_TAG  
  
ENV BRANCH "$BRANCH"  
ENV COMMIT "$COMMIT"  
ENV DATE "$DATE"  
ENV VERSION "$VERSION"  
ENV REV "$REV"  
ENV DOCKER_TAG "$DOCKER_TAG"  
  
  
LABEL org.label-schema.schema-version="1.0" \  
org.label-schema.build-date=$DATE \  
org.label-schema.vendor="Justin J. Novack" \  
org.label-schema.name="jnovack/dockerhub-hooks" \  
org.label-schema.description="Sample Docker Hub Build Hooks" \  
org.label-schema.version="$VERSION" \  
org.label-schema.ver="$REV" \  
org.label-schema.vcs-url=$URL \  
org.label-schema.vcs-branch=$BRANCH \  
org.label-schema.vcs-ref=$COMMIT  
  
  
COPY sleep.sh /  
  
ENTRYPOINT ["/sleep.sh"]  

