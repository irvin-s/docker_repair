FROM java:8  
ARG assembly  
RUN echo "assembly = ${assembly}"  
ENV assembly ${assembly}  
RUN mkdir /usr/src/myapp  
COPY ./$assembly /usr/src/myapp  
EXPOSE 8080  
WORKDIR /usr/src/myapp  
#CMD ["java", "-jar","${assembly}"]  
CMD rm -f RUNNING_PID && java -jar ${assembly}  

