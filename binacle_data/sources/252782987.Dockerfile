FROM mongo  
MAINTAINER GPN DATA programmers "dd@gpndata.com"  
ENV APP_HOME /mongo  
RUN mkdir $APP_HOME  
  
WORKDIR $APP_HOME  
  
COPY . $APP_HOME  
CMD ["./init.sh"]

