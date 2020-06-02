FROM ruby:2.3-alpine  
  
MAINTAINER Berkhan Berkdemir <berkberkdemir@gmail.com>  
  
ENV RAILS_ENV=production  
  
COPY . /usr/src/app  
WORKDIR /usr/src/app  
  
RUN chown $(id -un):$(id -gn) /usr/src/app \  
&& apk add --no-cache build-base tzdata \  
&& gem install bundler \  
&& bundle install --jobs $(grep -c processor /proc/cpuinfo) --no-color \  
&& apk del build-base  
  
EXPOSE 3000  
ENTRYPOINT ["bundle"]  
CMD ["exec", "rails", "s", "-p", "3000", "-b", "0.0.0.0"]  

