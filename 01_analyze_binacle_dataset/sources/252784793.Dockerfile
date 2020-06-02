FROM rocker/shiny  
  
COPY ./src /srv/shiny-server/src  
  
# install system package needed for some R packages  
RUN apt-get update && apt-get install -y --no-install-recommends libssl-dev  
  
# install R package to properly set working directory  
RUN install2.r --error envDocument  
  
RUN Rscript -e "source('/srv/shiny-server/src/000_run_pipeline.R')"  
  

