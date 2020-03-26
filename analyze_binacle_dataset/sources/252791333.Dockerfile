FROM rocker/tidyverse:3.4  
MAINTAINER Ildi Czeller <czeildi@gmail.com>  
  
RUN R -e "install.packages('plotly')"  
  
WORKDIR /home/rstudio  
  
COPY .rstudio /home/rstudio/.rstudio  
RUN chown -R rstudio:rstudio /home/rstudio/.rstudio  
  
RUN git clone https://github.com/czeildi/erum-2018-clean-r-code.git  
RUN chown -R rstudio:rstudio /home/rstudio/erum-2018-clean-r-code  

