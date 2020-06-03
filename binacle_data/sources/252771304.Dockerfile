FROM tomee:8-jre-7.0.3-webprofile  
COPY *.jar /usr/local/tomee/lib/  
COPY tomee.xml /usr/local/tomee/conf/tomee.xml  
RUN rm -rf /usr/local/tomee/webapps/ROOT  
#ADD target/xavier.war /usr/local/tomee/webapps/ROOT.war

