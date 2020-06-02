FROM andrewheiss/tidyverse-rstanarm  
LABEL maintainer="Andrew Heiss <andrew@andrewheiss.com>"  
  
# Install other important libraries  
# Cairo needs libxt-dev first  
# s3mpi needs python and pip first for s3cmd; also needs XML and pryr  
# Amelia needs RcppArmadillo  
RUN apt-get -y --no-install-recommends install \  
libxt-dev \  
python-pip \  
&& pip install s3cmd \  
&& install2.r --error \  
Cairo pander stargazer countrycode WDI \  
XML pryr \  
RcppArmadillo Amelia \  
&& R -e "library(devtools); \  
install_github('avantcredit/AWS.tools'); \  
install_github('kirillseva/cacher'); \  
install_github('robertzk/s3mpi')"  
  
# Move empty s3 configuration file to rstudio's home directory  
# NOTE: This will need to be hand-edited and renamed with a . prefix  
COPY cfg/s3cfg /home/rstudio/s3cfg  
RUN chown rstudio:rstudio /home/rstudio/s3cfg  
  
# ---------------  
# Install fonts  
# ---------------  
# Place to put fonts  
RUN mkdir -p $HOME/fonts  
  
# Source Sans Pro  
COPY scripts/install_source_sans.sh /root/fonts/install_source_sans.sh  
RUN . $HOME/fonts/install_source_sans.sh  
  
# Open Sans  
RUN mkdir -p /tmp/OpenSans  
COPY scripts/install_open_sans.sh /root/fonts/install_open_sans.sh  
COPY fonts/Open_Sans.zip /tmp/OpenSans/Open_Sans.zip  
RUN . $HOME/fonts/install_open_sans.sh  
  
# ---------------------------  
# Get project code and data  
# ---------------------------  
RUN cd /home/rstudio \  
&& git clone https://github.com/andrewheiss/donors-ngo-restrictions.git \  
&& chown -R rstudio:rstudio donors-ngo-restrictions  

