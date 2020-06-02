FROM contribu/buildenv_docker  
  
ENV APP_ROOT /app  
ENV RAILS_ENV production  
ENV LC_ALL=C.UTF-8  
ENV LANG=C.UTF-8  
WORKDIR $APP_ROOT  
  
COPY package.json $APP_ROOT  
COPY package-lock.json $APP_ROOT  
RUN npm install  
  
COPY Gemfile $APP_ROOT  
COPY Gemfile.lock $APP_ROOT  
RUN bundle install --jobs=8 --retry=3  
  
COPY . $APP_ROOT  
  
EXPOSE 3000  
CMD ['rails', 's']  

