FROM nodesource/trusty:0.10.40  
MAINTAINER Ivan Koptiev <ivan.koptiev@codex.systems>  
  
# Copy build tools  
COPY ./scripts/tools/ /opt/meteor/tools/  
COPY ./scripts/docker-entrypoint /usr/local/bin/  
  
# Install Meteor  
ENV METEOR_VERSION 1.2.1  
RUN /opt/meteor/tools/installer  
  
# Expose resources  
VOLUME /app  
EXPOSE 80  
# Deploy and build the code  
RUN /opt/meteor/tools/bootstrap  
ONBUILD COPY ./ /usr/local/src/meteor/  
ONBUILD RUN /opt/meteor/tools/bundle  
ONBUILD RUN /opt/meteor/tools/finish  
  
# Run application  
ENTRYPOINT ["docker-entrypoint"]  
CMD []

