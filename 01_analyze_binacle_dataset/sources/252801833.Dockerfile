FROM ubuntu:latest  
  
RUN apt-get update && apt-get upgrade && apt-get install pdfcrack  
RUN mkdir /pdf  
ENV MAX_LENGTH 6  
ENV MIN_LENGTH 4  
ENV CHAR_SET abcdefghjklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ  
ENV FILE_NAME default.pdf  
VOLUME /pdf  
  
CMD pdfcrack -f /pdf/$FILE_NAME -m $MAX_LENGTH -n $MIN_LENGTH -c $CHAR_SET -o  

