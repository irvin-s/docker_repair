FROM rocker/tidyverse  
RUN R -e "remotes::install_github('eRum2018-talk/erum2018')"  

