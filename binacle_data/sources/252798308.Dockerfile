FROM ruby:2.3-alpine  
MAINTAINER Micheal Waltz <mwaltz@demandbase.com>  
  
#Set environment vars  
ENV APP_DIR /app \  
ACCOUNT \  
API_KEY \  
SLACK_NAMES  
  
#Copy Gemfile for gem install  
RUN mkdir -p ${APP_DIR}  
WORKDIR ${APP_DIR}  
COPY Gemfile ${APP_DIR}  
  
## Install build packages, bundle packages locally, using the GITHUB_TOKEN  
## for caching, and then unsetting GITHUB_TOKEN so the Gemfile vendors the  
## cached gems. Removing the virtual package causes this layer to zero-out  
## significantly reducing the size of the image  
RUN apk --no-cache add \  
\--virtual build-dependencies \  
build-base \  
libffi-dev \  
libxml2-dev \  
libxslt-dev \  
ruby-dev \  
zlib-dev && \  
bundle install && \  
apk del build-dependencies  
  
#Copy the app after building gems  
COPY . ${APP_DIR}  
  
#Rack port  
EXPOSE 9292  
#App command  
ENTRYPOINT ["bundle"]  
CMD ["exec", "rackup", "-o", "0.0.0.0"]  

