# Based on https://github.com/sashaegorov/docker-alpine-sinatra  
FROM gliderlabs/alpine:3.3  
MAINTAINER den-chan <den-chan@tuta.io>  
  
RUN echo 'gem: --no-document' >/etc/gemrc  
RUN apk-install \  
alpine-sdk \  
ruby-dev \  
ruby \  
ruby-bundler \  
ruby-io-console  
RUN gem install bundler  
  
RUN mkdir /usr/app  
WORKDIR /usr/app  
  
COPY Gemfile Gemfile.lock /usr/app/  
RUN bundle install && \  
gem clean && \  
apk -U --purge del \  
alpine-sdk \  
ruby-dev  
RUN apk-install libstdc++  
  
COPY app.rb \  
config.ru \  
Procfile /usr/app/  
EXPOSE 80  
ENV PORT=80  
CMD ["foreman", "start"]  

