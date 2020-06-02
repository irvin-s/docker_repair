## TissueMiner and Rstudio server setup on Ubuntu
# Inspired from https://github.com/rocker-org/rocker
# 486a544e072d
## see https://www.digitalocean.com/community/tutorials/docker-explained-using-dockerfiles-to-automate-building-of-images
# https://docs.docker.com/articles/dockerfile_best-practices/
# see https://registry.hub.docker.com/u/rocker/shiny/dockerfile/


#FROM ubuntu:14.04
FROM rocker/rstudio

MAINTAINER "Raphael Etournay and Holger Brandl" brandl@mpi-cbg.de

#LABEL Description="TM rstudio server" TMversion="1.1"

## security updates for ubuntu and install curl and wget
RUN apt-get update && apt-get upgrade -y && apt-get install -y curl wget

## install TM dependencies without cloning the repository. This allows for a more efficient use of the docker build cache
RUN /bin/bash -c "source <(curl https://raw.githubusercontent.com/mpicbg-scicomp/tissue_miner/master/installation/ubuntu/install_dependencies.sh | sed 's/sudo//g')"  ## bump2


## clone TM locally and compile the parser needed to convert TissueAnalyzer outputs into csv
RUN mkdir /tissue_miner && git clone https://github.com/mpicbg-scicomp/tissue_miner /tissue_miner \
	&& cd /tissue_miner/parser && make


## Set up a rstudio user.
## Add user to 'rstudio' group, granting them write privileges to /usr/local/lib/R/site.library
## User should also have & own a home directory (for rstudio or linked volumes to work properly). 
#RUN useradd rstudio \
#	&& mkdir /home/rstudio \
#	&& chown rstudio:rstudio /home/rstudio \
#	&& addgroup rstudio staff


## Install additional required R packages and additional packages for Rstudio in rstudio user space (Rmd, etc...)
RUN /bin/bash -c "export TM_HOME='/tissue_miner'; su rstudio -c /tissue_miner/Setup.R && /tissue_miner/misc/rstudio_TM_docker_image/RstudioSetup.R" 

## Set up R and bash environments
COPY rocker_Renviron /home/rstudio/.Renviron
#COPY rocker_Rprofile /home/rstudio/.Rprofile
COPY docker_bash_profile.sh /home/rstudio/.bash_profile


## Configure default locale, see https://github.com/rocker-org/rocker/issues/19
#RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
#	&& locale-gen en_US.utf8 \
#	&& /usr/sbin/update-locale LANG=en_US.UTF-8
#
#ENV LC_ALL en_US.UTF-8
#ENV LANG en_US.UTF-8
#ENV PATH /usr/lib/rstudio-server/bin/:$PATH


## Download and install RStudio server & dependencies
## Attempts to get detect latest version, otherwise falls back to version given in $VER
#RUN apt-get update \
#&& apt-get install -y \
#libapparmor1 \
#libcurl4-openssl-dev \
#psmisc \
#python-setuptools \
#libedit2

#RUN VER=$(wget --no-check-certificate -qO- https://s3.amazonaws.com/rstudio-server/current.ver) \
#&& wget -q http://download2.rstudio.org/rstudio-server-${VER}-amd64.deb \
#&& dpkg -i rstudio-server-${VER}-amd64.deb \
#&& rm rstudio-server-*-amd64.deb \
#&& ln -s /usr/lib/rstudio-server/bin/pandoc/pandoc /usr/local/bin \
#&& ln -s /usr/lib/rstudio-server/bin/pandoc/pandoc-citeproc /usr/local/bin \
#&& wget https://github.com/jgm/pandoc-templates/archive/1.15.0.6.tar.gz \
#&& mkdir -p /opt/pandoc/templates && tar zxf 1.15.0.6.tar.gz \
#&& cp -r pandoc-templates*/* /opt/pandoc/templates && rm -rf pandoc-templates* \
#&& mkdir /root/.pandoc && ln -s /opt/pandoc/templates /root/.pandoc/templates


## Ensure that if both httr and httpuv are installed downstream, oauth 2.0 flows still work correctly.
#RUN echo '\n\
#\n# Configure httr to perform out-of-band authentication if HTTR_LOCALHOST \
#\n# is not set since a redirect to localhost may not work depending upon \
#\n# where this Docker container is running. \
#\nif(is.na(Sys.getenv("HTTR_LOCALHOST", unset=NA))) { \
#\n  options(httr_oob_default = TRUE) \
#\n}' >> /etc/R/Rprofile.site

#RUN wget -P /tmp/ https://github.com/just-containers/s6-overlay/releases/download/v1.11.0.1/s6-overlay-amd64.tar.gz \
#  && tar xzf /tmp/s6-overlay-amd64.tar.gz -C /

## Clean up installations
RUN apt-get clean \
	&& rm -rf /var/lib/apt/lists/*


#COPY userconf.sh /etc/cont-init.d/conf
#COPY run_rstudio_server.sh /etc/services.d/rstudio/run

EXPOSE 8787

## Source .bash_profile when running the container to setup ENV variables
COPY docker_entrypoint.sh /home/rstudio/
ENTRYPOINT ["/home/rstudio/docker_entrypoint.sh"]

## Start RStudio server
CMD ["/init"]















############# DROPPED OPTIONS #############

### http://stackoverflow.com/questions/20635472/using-the-run-instruction-in-a-dockerfile-with-source-does-not-work
#RUN /bin/bash -c "export TM_HOME='/tissue_miner'; source /tissue_miner/installation/ubuntu/install_tm.sh"

## install virtual xserver because imageParser needs it
# run without x https://linuxmeerkat.wordpress.com/2014/10/17/running-a-gui-application-in-a-docker-container/
#RUN apt-get install -y xvfb

#USER rstudio # prevents rstudio server from starting


