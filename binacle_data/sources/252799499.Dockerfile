FROM tomcat:8.5-alpine  
MAINTAINER Analyser, analyser@gmail.com  
  
## Add package  
# 1) modify local timezone  
# 2) ttf-dejavu font package used by verify code generation.  
RUN apk add --no-cache tzdata ttf-dejavu unzip && \  
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \  
echo "Asia/Shanghai" > /etc/timezone && \  
apk del --no-cache tzdata && \  
rm -rf /var/cache/apk/*  
  
COPY server.xml /usr/local/tomcat/conf/  
COPY context.xml.default /usr/local/tomcat/conf/Catalina/localhost/  
  
ENV FC_LANG en-US  
  
CMD ["catalina.sh", "run"]  
  
RUN rm -rf /usr/local/tomcat/webapps/*  

