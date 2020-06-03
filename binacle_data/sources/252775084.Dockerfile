FROM bde2020/flume:latest  
  
MAINTAINER Juergen Jakobitsch <jakobitschj@semantic-web.at>  
  
ADD flume-startup.json /config/  
ADD sc6-flume-agent /config/  

