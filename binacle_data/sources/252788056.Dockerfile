FROM earthlab/r-tensorflow  
LABEL maintainer="Stefan Kuethe <crazycapivara@gmail.com>"  
RUN install2.r tensorflow  
COPY ./scripts /home/rstudio/scripts  
RUN chown -R rstudio:rstudio /home/rstudio/scripts  
  

