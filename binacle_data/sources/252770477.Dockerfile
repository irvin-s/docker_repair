FROM ruby:2.4  
MAINTAINER aspgems  
  
ENV BRAKEMAN_VERSION=3.6.1  
RUN gem install brakeman --version ${BRAKEMAN_VERSION} \--no-format-exec  
  
WORKDIR /tmp  
  
ENTRYPOINT ["brakeman"]  
CMD ["--help"]  
  

