FROM ruby:2.4-alpine  
  
LABEL maintainer="Clearhaus"  
  
WORKDIR /opt/pedicel-pay  
COPY . /opt/pedicel-pay  
RUN bundle install  
  
ENTRYPOINT ["/opt/pedicel-pay/exe/pedicel-pay"]  

