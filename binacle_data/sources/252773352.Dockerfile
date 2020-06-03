FROM rails:onbuild  
RUN gem install foreman  
  
WORKDIR /usr/src/app  
  
CMD foreman start  
  

