FROM swipl:7.7.10  
LABEL maintainer "Dave Curylo <dave@curylo.org>"  
ADD https://github.com/SWI-Prolog/pengines/archive/master.tar.gz /  
RUN tar -xzf master.tar.gz && mv pengines-master pengines && rm master.tar.gz  
# Expose the default port for pengines  
EXPOSE 3030  
# Set the pengines admin account to admin:admin  
RUN echo 'admin:$1$vUXiHMJy$DI1JHDLqTytUYGTHicJvE0' >>/pengines/passwd  
WORKDIR /pengines  
ENTRYPOINT ["swipl"]  
CMD ["daemon.pl","--port=3030","--fork=false"]  

