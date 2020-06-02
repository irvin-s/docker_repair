FROM rocker/r-base  
  
RUN apt-get update  
RUN apt-get install -y libxml2-dev  
RUN apt-get install -y libcurl4-gnutls-dev  
  
COPY mlb-analytics-engine.R .  
  
CMD ["Rscript", "mlb-analytics-engine.R"]

