FROM ruby  
  
RUN apt-get update -y && apt-get install -y nodejs npm  
RUN ln /usr/bin/nodejs /usr/bin/node  
  
WORKDIR /app  
  
COPY ./Gemfile /app/Gemfile  
COPY ./package.json /app/package.json  
  
RUN npm install  
RUN bundle install  
RUN npm install -g http-server bower  
  
COPY ./ /app  
ENV LC_ALL=C.UTF-8  
ENV LANG=C.UTF-8  
RUN ruby build.rb  
RUN bower install --allow-root  
RUN bundle exec jekyll build  
EXPOSE 8000  
WORKDIR /app/_site  
CMD http-server -p 8000 -a 0.0.0.0 -d false  

