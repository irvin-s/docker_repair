FROM ascendhit/ruby-plus:latest  
  
# create the /app/user directory  
ENV APP_HOME /app/user  
RUN mkdir -p $APP_HOME  
  
# set this as the working directory  
WORKDIR $APP_HOME  
  
# install mailcatcher  
RUN gem install mailcatcher  
  
EXPOSE 1025  
EXPOSE 1080  
ENTRYPOINT ["mailcatcher", "-f"]  
CMD ["--ip", "0.0.0.0"]  
  

