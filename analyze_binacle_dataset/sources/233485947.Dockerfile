FROM statsplot/jshinyserver:latest


# =====================================================================
# https://github.com/rstudio/shiny-examples/tree/master/docker
# MAINTAINER Winston Chang "winston@rstudio.com"
# Install shiny examples and dependencies;
# based on statsplot/jshinyserver:latest with CRAN shiny
# =====================================================================

# =====================================================================
# R
# =====================================================================


# Don't print "debconf: unable to initialize frontend: Dialog" messages
ARG DEBIAN_FRONTED=noninteractive


RUN apt-get update && apt-get install -y libssl-dev


	
# =====================================================================
# Shiny Examples
# =====================================================================


RUN apt-get update && apt-get install -y libxml2-dev

RUN R -e "install.packages(c('devtools', 'packrat'))"

# For deploying apps from a container
RUN R -e "devtools::install_github('rstudio/rsconnect')"

# Install shiny-examples
RUN mkdir -p /srv/shiny-server && \
	cd /srv && \
    mv shiny-server shiny-server-orig && \
    wget -nv https://github.com/rstudio/shiny-examples/archive/master.zip && \
    unzip -x master.zip && \
    mv shiny-examples-master shiny-server && \
    rm master.zip && \
    rm -r /srv/shiny-server/docker && \
    echo shinyfolder=/srv/shiny-server >> /opt/shiny/server/config/system_linux.conf

# Autodetect packages needed for the examples (will install from CRAN)
RUN R -e "install.packages(packrat:::dirDependencies('/srv/shiny-server'))"

# Packages that need to be installed from GitHub
# For 087-crandash
RUN R -e "devtools::install_github('hadley/shinySignals')"
RUN R -e "devtools::install_github('jcheng5/bubbles')"

# Install latest shiny from GitHub
# RUN R -e "devtools::install_github('rstudio/shiny')"

# latest shiny from CRAN 
# RUN R -e "install.packages(c('shiny'))"


