FROM rocker/rstudio  
LABEL maintainer="Stefan Kuethe <crazycapivara@gmail.com>"  
RUN apt-get update && apt-get install -y \  
libssl-dev \  
libsasl2-dev  
RUN install2.r mongolite remotes httr \  
&& installGithub.r metacran/cranlogs  
COPY ./scripts /home/rstudio/scripts  
  

