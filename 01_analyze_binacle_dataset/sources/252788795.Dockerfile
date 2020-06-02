FROM alpine  
  
RUN apk update  
RUN apk add nodejs-npm python2  
  
COPY ext /ext  
COPY reveal-multiplex /ext/lib/reveal-multiplex  
  
CMD /ext/bin/cucyber-init  
  
EXPOSE 1948  

