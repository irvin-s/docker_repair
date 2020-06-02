FROM alpine:latest  
RUN apk add \--no-cache curl  
ADD ./create-snapshot .  
CMD sh ./create-snapshot

