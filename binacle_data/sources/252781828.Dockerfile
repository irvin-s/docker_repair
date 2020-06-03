FROM alpine:latest  
  
RUN apk --no-cache add curl  
  
COPY run.sh .  
  
ENV SLEEP=5  
CMD sh ./run.sh  

