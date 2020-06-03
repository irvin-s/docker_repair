FROM ruby:2.4.1  
MAINTAINER david.morcillo@codegram.com  
  
# Environment  
ENV WORKDIR=/code  
ENV LANG=C.UTF-8  
ENV GITHUB_ORGANIZATION=  
ENV GITHUB_REPO=  
ENV GITHUB_OAUTH_TOKEN=  
ENV DATABASE_HOST=db  
ENV DATABASE_USERNAME=postgres  
ENV DATABASE_PASSWORD=  
ENV DATABASE_NAME=  
ENV DECIDIM_GITHUB_ORGANIZATION=  
ENV DECIDIM_GITHUB_REPO=  
ENV DECIDIM_VERSION=  
ENV GIT_USERNAME=decidim-bot  
ENV GIT_EMAIL=info+decidim-bot@codegram.com  
  
# Volumes  
VOLUME /usr/local/bundle  
  
# Install system dependencies  
RUN apt-get update && apt-get install -y \  
git \  
build-essential \  
libxml2-dev \  
libxslt-dev \  
nodejs \  
jq \  
&& rm -rf /var/cache/apt/*  
  
# Create working directory  
RUN mkdir -p $WORKDIR  
WORKDIR $WORKDIR  
  
# Run docker-entrypoint.sh by default  
ADD docker-entrypoint.sh .  
ENTRYPOINT bash docker-entrypoint.sh  

