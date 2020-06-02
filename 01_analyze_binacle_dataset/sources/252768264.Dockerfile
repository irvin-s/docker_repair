from debian:9  
# package manager deps  
RUN apt-get update && apt-get install -y \  
build-essential \  
libfftw3-dev \  
libgsl-dev \  
libjson-c-dev \  
liblua5.1-dev \  
libreadline-dev \  
libpq-dev \  
wget  
  
RUN mkdir -p /home/admx/epics  
  
# setup and build eipcs itself  
COPY epics_build_vars.sh /usr/local/bin/epics_build_vars.sh  
RUN cat /usr/local/bin/epics_build_vars.sh >> /etc/bash.bashrc  
  
# add --no-check-certificate if anl doesn't get their certs updated  
RUN cd /home/admx/epics &&\  
wget https://www.aps.anl.gov/epics/download/base/baseR3.14.12.6.tar.gz &&\  
tar -xvzf baseR3.14.12.6.tar.gz &&\  
cd base-3.14.12.6 && \  
make clean uninstall &&\  
make  
  
## build asyn4  
COPY asyn4.32.release /home/admx/epics/asyn4.32.release  
RUN cd /home/admx/epics &&\  
wget https://www.aps.anl.gov/epics/download/modules/asyn4-32.tar.gz &&\  
tar -xvzf asyn4-32.tar.gz &&\  
cd asyn4-32 &&\  
mv /home/admx/epics/asyn4.32.release ./configure/RELEASE &&\  
make  
  
# stream devices  
RUN cd /home/admx/epics/asyn4-32 &&\  
wget http://epics.web.psi.ch/software/streamdevice/StreamDevice-2.tgz &&\  
tar -xvzf StreamDevice-2.tgz &&\  
cd /home/admx/epics/asyn4-32/StreamDevice-2-6 &&\  
make  

