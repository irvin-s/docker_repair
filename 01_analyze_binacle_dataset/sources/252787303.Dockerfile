FROM rocker/r-base  
  
RUN apt-get update \  
&& apt-get install -y \  
libxml2-dev \  
libcurl4-gnutls-dev  
  
COPY mlb-analytics-engine.R .  
  
CMD ["Rscript", "mlb-analytics-engine.R"]

