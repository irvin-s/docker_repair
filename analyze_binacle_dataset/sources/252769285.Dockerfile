FROM alpine:3.6  
RUN apk add --no-cache make gcc g++ python  
RUN apk add --update nodejs nodejs-npm git  
  
ADD ./config/start.sh /home/  
  
RUN chmod u+x /home/start.sh  
  
CMD ["/home/start.sh"]  

