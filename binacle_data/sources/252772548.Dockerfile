FROM awilson/wlslib  
MAINTAINER Ash Wilson  
  
RUN apt-get update && apt-get install -y vim  
RUN /root/.rbenv/shims/gem install oauth2 rest-client json public_suffix ip  
RUN mkdir -m 700 /root/api_cache  
RUN mkdir -p /opt/cloudpassage/where-are-they-now  
COPY ./README.md /  
COPY ./README.md /root/  
COPY ./README.md /opt/cloudpassage/where-are-they-now/  
COPY ./LICENSE.txt /opt/cloudpassage/where-are-they-now/  
COPY ./where-are-they-now.rb /opt/cloudpassage/where-are-they-now/  
WORKDIR /opt/cloudpassage/where-are-they-now/  

