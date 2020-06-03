FROM eduard44/vertex:1.0.0  
MAINTAINER Eduardo Trujillo <ed@chromabits.com>  
  
ADD docker /  
  
RUN chmod +x /opt/start.sh && chmod +x /opt/install_phantomjs.sh  
  
RUN /opt/install_phantomjs.sh  
RUN npm install -g ircdjs  
  
RUN mkdir -p /opt/xss/  
  
WORKDIR /opt/xss/  
  
ADD . /opt/xss/  
  
RUN rm -rf node_modules && npm install  
  
EXPOSE 6667  
CMD /opt/start.sh

