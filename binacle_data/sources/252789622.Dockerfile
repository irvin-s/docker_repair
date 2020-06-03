FROM openjdk:8u131-jre-alpine  
COPY prepare.sh /tmp/prepare.sh  
COPY entry.sh /entry.sh  
RUN /tmp/prepare.sh  
WORKDIR /jmeter  
EXPOSE 1099 20000  
VOLUME ["/jmeter/input", "/jmeter/output"]  
CMD ["/entry.sh"]  

