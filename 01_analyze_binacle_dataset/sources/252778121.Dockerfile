FROM rocker/shiny  
  
RUN apt-get update  
RUN apt-get install -y libssl-dev libssh2-1-dev  
RUN R -e 'install.packages(c("devtools","shinyBS","jsonlite","ggplot2","DT"))'  
RUN R -e 'devtools::install_github("michalkouril/irapgen")'  
RUN mv /srv/shiny-server/ /srv/shiny-server-  
RUN mkdir /var/lib/shiny-server/bookmarks  
RUN chown -R root /var/lib/shiny-server  
  
ADD . /srv/shiny-server  

