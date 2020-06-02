FROM ruby:2.3-alpine  
  
ENV VERSION=1.3.3  
WORKDIR /usr/src/app  
RUN apk --no-cache add --virtual .build-deps \  
build-base \  
curl \  
ruby-dev \  
# ruby-bundler \  
# ruby-io-console \  
nodejs \  
libxml2-dev \  
libxslt-dev \  
linux-headers \  
libffi-dev \  
zlib-dev && \  
(\  
mkdir -p /opt/src && \  
cd /opt/src && \  
curl -L https://github.com/lord/slate/archive/v$VERSION.tar.gz | tar -xz && \  
cp -R slate-$VERSION/* /usr/src/app/ && \  
rm -rf /opt/src \  
) && \  
bundle config build.nokogiri --use-system-libraries && \  
bundle install  
# apk del .build-deps  
VOLUME ["/usr/src/app/source"]  
EXPOSE 80/tcp  
CMD ["bundle", "exec", "middleman", "server", "--port", "80"]  

