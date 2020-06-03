FROM ruby:alpine  
  
COPY Gemfile /Gemfile  
  
RUN mkdir -p /opt/resource && \  
apk --no-cache add git build-base libxml2-dev libxslt-dev && \  
bundle config build.nokogiri --use-system-libraries && \  
rm -rf /var/cache/apk/* && \  
bundle install && \  
apk del build-base git  
  
COPY check /opt/resource/check  
COPY in /opt/resource/in  
COPY out /opt/resource/out  
COPY slack.erb /opt/resource/slack.erb  
  

