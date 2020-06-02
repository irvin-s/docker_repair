FROM rocker/rstudio:latest  
MAINTAINER B2B.Web.ID Data Analytics Platform Labs  
COPY clouderaimpalaodbc_2.5.32.1002-2_amd64.deb /root  
COPY installpackages.R /root  
RUN apt-get update && \  
apt-get install -y \  
unixodbc unixodbc-dev \  
git \  
libsasl2-modules-gssapi-mit && \  
dpkg -i /root/clouderaimpalaodbc_2.5.32.1002-2_amd64.deb && \  
rm /root/clouderaimpalaodbc_2.5.32.1002-2_amd64.deb && \  
apt-get autoremove -y && \  
apt-get clean && \  
Rscript --verbose /root/installpackages.R  
EXPOSE 8787  
VOLUME /home/rstudio  
CMD ["/init"]  

