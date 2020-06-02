FROM alpine  
  
RUN apk --update add busybox jq curl  
RUN apk upgrade \--available  
  
COPY *.sh /  
  
CMD /launcher.sh

