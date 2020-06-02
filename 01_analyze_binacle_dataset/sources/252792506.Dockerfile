FROM ruby:2.4.1  
MAINTAINER David Anguita <david@davidanguita.name>  
  
ENV TWITTER_GEM_VERSION=6.1.0  
ENV OCTOKIT_GEM_VERSION=4.6.2  
  
RUN gem install twitter --version $TWITTER_GEM_VERSION  
RUN gem install octokit --version $OCTOKIT_GEM_VERSION  
RUN mkdir /script  
WORKDIR /script  
  
ADD . /script  

