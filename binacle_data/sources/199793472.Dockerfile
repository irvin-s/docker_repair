FROM rocker/shiny
MAINTAINER mdagost@gmail.com

RUN DEBIAN_FRONTEND=noninteractive apt-get update -y 
RUN apt-get install -y libssl-dev imagemagick

RUN R -e "install.packages(c('httr', 'RCurl'), repos='http://cran.rstudio.com/')"

COPY ui.R /srv/shiny-server/pugs/ui.R
COPY server.R /srv/shiny-server/pugs/server.R
COPY www/app.css /srv/shiny-server/pugs/www/app.css

EXPOSE 3838
CMD ["/usr/bin/shiny-server.sh"]
