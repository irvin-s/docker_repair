FROM ruby:2.3-slim  
  
ARG BUILD_DATE  
ARG MAKEFLAGS=-j12  
ARG VCS_REF  
  
LABEL org.label-schema.build-date=$BUILD_DATE \  
org.label-schema.name="Beef" \  
org.label-schema.description="Browser Exploitation Framework" \  
org.label-schema.url="https://beefproject.com" \  
org.label-schema.vcs-ref=$VCS_REF \  
org.label-schema.vcs-url="https://github.com/brianclemens/docker-beef" \  
org.label-schema.schema-version="1.0"  
  
ENV LANG="C.UTF-8" \  
BUILD_DEPS=" \  
build-essential \  
git \  
libsqlite3-dev" \  
RUNTIME_DEPS=" \  
sqlite3"  
RUN apt-get update; \  
apt-get install -y ${BUILD_DEPS} ${RUNTIME_DEPS}; \  
useradd -m beef; \  
cd /home/beef; \  
git clone \--depth=1 https://github.com/beefproject/beef.git; \  
cd beef; \  
gem install rake; \  
bundle install --without test development; \  
chown -R beef /home/beef/beef; \  
rm -rf /home/beef/beef/.git; \  
apt-get purge -y ${BUILD_DEPS}; \  
apt-get -y autoremove; \  
rm -rf /var/lib/apt/lists/*  
  
EXPOSE 3000 6789 61985 61986  
USER beef  
  
ENTRYPOINT ["/home/beef/beef/beef"]  

