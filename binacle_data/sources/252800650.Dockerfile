FROM alpine:{{BRANCH}}  
  
ARG BRANCH  
ENV BRANCH $BRANCH  
  
RUN echo $BRANCH  

