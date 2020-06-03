FROM rocker/rstudio

RUN R -e 'install.packages("lubridate")'
