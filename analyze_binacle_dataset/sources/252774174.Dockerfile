FROM ruby:2.4  
MAINTAINER thinkbot@outlook.de  
  
ENV VERSION=0.3.11  
RUN gem install cfn-nag --version ${VERSION} \--no-format-exec  
  
WORKDIR /work  
  
ENTRYPOINT ["cfn_nag"]  
CMD ["--help"]  

