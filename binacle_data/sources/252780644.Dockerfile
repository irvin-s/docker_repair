FROM debian:stretch-slim  
  
ARG CACHE_TAG  
ARG IMAGE_NAME  
ARG SOURCE_BRANCH  
  
RUN echo $CACHE_TAG  
RUN echo $IMAGE_NAME  
RUN echo $SOURCE_BRANCH  
  
CMD ["echo", "PIPO"]  
  

