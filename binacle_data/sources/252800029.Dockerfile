FROM dimkk/ant  
MAINTAINER dimkk  
  
COPY . /var/l2  
  
RUN ant -buildfile "/var/l2/build - Commons.xml" build  
RUN ant -buildfile "/var/l2/build - AuthServer.xml" build  
  
WORKDIR /var/l2/dist/loginserver  
  
EXPOSE 2106 9014  
CMD ["sh", "AuthServer_loop.sh"]

