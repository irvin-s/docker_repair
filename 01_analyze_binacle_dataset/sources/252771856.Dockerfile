FROM ruby:alpine  
RUN apk add --update --no-cache nginx  
COPY app.rb template.erb /  
EXPOSE 80  
ENTRYPOINT ["ruby", "/app.rb"]  

