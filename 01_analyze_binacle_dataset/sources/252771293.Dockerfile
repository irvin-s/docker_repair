FROM ruby:2.3  
MAINTAINER devops@airhelp.com  
  
ENV RACK_ENV production  
ENV GEMSTASH_VERSION=1.0.3  
EXPOSE 9292  
RUN gem install gemstash --version $GEMSTASH_VERSION  
  
CMD ["gemstash", "start", "--no-daemonize"]  

