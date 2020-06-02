FROM 6fusion/vmware-meter:0.9.26  
MAINTAINER Delano Seymour <dseymour@6fusion.com>  
  
RUN mkdir /usr/meter  
WORKDIR /usr/meter/bin  
  
COPY Gemfile /usr/meter/  
COPY Gemfile.lock /usr/meter/  
RUN bundle install  
  
COPY . /usr/meter  
  
CMD ruby openshift-meter.rb  

