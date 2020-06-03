FROM r-base  
  
MAINTAINER Arun Ramakani <energyarun.r@gmail.com>  
  
COPY test.csv test.csv  
COPY preprocess.R preprocess.R  
COPY entrypoint.sh entrypoint.sh  
  
RUN chmod 755 /preprocess.R  
RUN chmod 755 /entrypoint.sh  
RUN chmod 777 /test.csv  
  
ENTRYPOINT ["./entrypoint.sh"]  
  

