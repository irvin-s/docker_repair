FROM ruby:alpine  
MAINTAINER Edgar Castanheda <edaniel15@gmail.com> (@Edux87)  
  
ENV TERM xterm  
  
RUN mkdir -p /src/site  
WORKDIR /src  
  
RUN apk add --no-cache build-base gcc libcurl make  
  
RUN gem install bundler  
RUN gem install jekyll  
  
COPY ./Gemfile /src  
RUN cd /src && bundler install  
  
COPY ./main.sh /src  
ENV JEKYLL_ENV development  
EXPOSE 4000  
ENTRYPOINT ["sh", "main.sh"]  

