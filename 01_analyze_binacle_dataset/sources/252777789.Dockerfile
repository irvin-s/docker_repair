FROM ruby  
MAINTAINER Artem Sykchin anydasa@gmail.com  
  
RUN gem install listen  
RUN gem install compass  
RUN gem install compass-core  
  
VOLUME /src  
  
WORKDIR /src  
  
ENTRYPOINT [ "compass" ]  

