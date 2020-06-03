FROM rocker/r-base
MAINTAINER Carl Boettiger cboettig@ropensci.org

## Shiny
RUN Rscript -e 'install.packages("shiny", repos="http://cran.rstudio.com")'
RUN wget http://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.2.1.362-amd64.deb && sudo gdebi --non-interactive shiny-server-*.deb
EXPOSE 3838

CMD ["/usr/bin/shiny-server"]

