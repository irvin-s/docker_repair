FROM ruby:2.4-alpine3.6  
LABEL Maintainer="Damien DUPORTAL <damien.duportal@gmail.com>"  
  
RUN apk --no-cache add \  
bash \  
git \  
nodejs \  
nodejs-npm \  
openssh-client \  
&& npm install -g gulp  
  
WORKDIR /app  
COPY Gemfile* /app/  
COPY ./package.json /app/  
COPY ./npm-shrinkwrap.json /app/  
RUN bundle install \  
&& npm install  
  
WORKDIR /app/src  
  
EXPOSE 4000 35729  
ENTRYPOINT ["gulp"]  
CMD ["default"]  

