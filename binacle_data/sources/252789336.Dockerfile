FROM mhart/alpine-node:8  
RUN apk add --no-cache \  
build-base \  
libxml2-dev \  
libxslt-dev \  
curl  
  
RUN apk --update add --no-cache g++ musl-dev make  
  
RUN apk update && apk upgrade && \  
apk add --no-cache bash git openssh  
  
RUN apk add --update openssl && \  
rm -rf /var/cache/apk/*  
  
COPY gemrc $HOME/.gemrc  
  
RUN apk update && apk upgrade && \  
apk add openjdk7-jre --no-cache && \  
mkdir /tmp/tmprt && \  
cd /tmp/tmprt && \  
apk add zip --no-cache && \  
unzip -q /usr/lib/jvm/default-jvm/jre/lib/rt.jar && \  
zip -q -r /tmp/rt.zip . && \  
apk del zip && \  
cd /tmp && \  
mv rt.zip /usr/lib/jvm/default-jvm/jre/lib/rt.jar && \  
rm -rf /tmp/tmprt /var/cache/apk/*  
  
RUN apk --update add --no-cache\  
ca-certificates \  
ruby=2.4.4-r0 \  
ruby-dev=2.4.4-r0 \  
ruby-json=2.4.4-r0 &&\  
gem install bundler -v 1.16.1 --no-rdoc --no-ri &&\  
rm -fr /usr/share/ri  
  
RUN mkdir /usr/app  
WORKDIR /usr/app  
  
COPY Gemfile /usr/app/  
COPY Gemfile.lock /usr/app/  
RUN bundle install  
RUN s3_website install  
  
COPY package.json /usr/app/  
COPY yarn.lock /usr/app/  
RUN yarn  
  
RUN rm -rf Gemfile Gemfile.lock package.json yarn.lock  
  
CMD ["/bin/sh"]  

