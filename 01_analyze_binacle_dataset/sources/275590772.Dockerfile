FROM databio/shinybase:latest

MAINTAINER VP Nagraj "vpnagraj@virginia.edu"

# move conf files
COPY shiny-server.conf  /etc/shiny-server/shiny-server.conf
COPY shiny-server.sh /usr/bin/shiny-server.sh

# get the code
WORKDIR /srv/shiny-server
RUN git clone -b dev https://github.com/databio/LOLAweb.git

# add dir for cache
RUN mkdir LOLAweb/cache
RUN chown -R shiny:shiny LOLAweb/cache

# add plots dir for zipping up all figures to download with one button
RUN mkdir LOLAweb/apps/LOLAweb/plots
RUN chown -R shiny:shiny LOLAweb/apps/LOLAweb/plots

# run the server setup script
CMD ["/usr/bin/shiny-server.sh"]
