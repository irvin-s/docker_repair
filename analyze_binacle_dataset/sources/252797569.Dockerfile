FROM alpine:latest  
RUN apk --no-cache add borgbackup openssh-client  
CMD ["borg"]  

