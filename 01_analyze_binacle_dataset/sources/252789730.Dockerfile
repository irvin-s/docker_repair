FROM dwilding/digits  
MAINTAINER David Wilding <wilding@gmail.com>  
  
RUN mkdir /DATA && \  
mkdir /DATA/digits && \  
mkdir /DATA/digits/jobs && \  
mkdir /DATA/digits/logs  
  
WORKDIR /home/digits  
COPY digits.cfg digits/digits.cfg  
EXPOSE 5000  
CMD ["./digits-devserver"]  

