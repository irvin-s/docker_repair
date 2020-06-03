FROM gcr.io/stacksmith-images/ubuntu:14.04-buildpack  
MAINTAINER Bitnami <containers@bitnami.com>  
  
LABEL com.bitnami.stacksmith.id="Pu6WAjw" \  
com.bitnami.stacksmith.name="Rails"  
  
ENV STACKSMITH_STACK_ID="Pu6WAjw" \  
STACKSMITH_STACK_NAME="Rails"  
ENV STACKSMITH_STACK_PRIVATE=1  
# Runtime  
RUN bitnami-pkg-install ruby-2.2.3-1  
  
# Framework  
RUN bitnami-pkg-install rails-4.2.4-0  
  
# Runtime template  
ENV PATH=/opt/bitnami/ruby/bin:$PATH  
  
# Add app directory  
ADD . /app  
RUN chown -R bitnami:bitnami /app  
  
USER bitnami  
WORKDIR /app  
#RUN bundle install  
EXPOSE 3000  
CMD ["bundle", "exec", "rackup", "-o", "0.0.0.0"]  

