FROM debian:jessie  
MAINTAINER Dumitru  
  
LABEL description="Tokyo Tyrant image" version="0.0.1"  
EXPOSE 35871  
ENV TYRANT_DB_PATH=/var/ttserver\  
TYRANT_BUCKETS=18000000  
ENV TYRANT_DB_NAME=${TYRANT_DB_PATH}/audiorama.tch#bnum=${TYRANT_BUCKETS}  
RUN mkdir ${TYRANT_DB_PATH}  
  
RUN apt-get update && apt-get install -y tokyotyrant tokyocabinet-bin  
  
VOLUME /var/ttserver  
  
ENTRYPOINT ["ttserver"]  
CMD ["-help"]  

