# Start with a Python image.  
FROM python:3.6-stretch as slurm  
LABEL maintainer="Brian May <brian@linuxpenguins.xyz>"  
  
# Install OS dependencies  
RUN apt-get update \  
&& apt-get install -y \  
bzip2 make gcc libmunge-dev liblua5.3-dev \  
&& rm -rf /var/lib/apt/lists/*  
  
# Slurm configuration  
ARG SLURM_VER=17.11.6  
ARG SLURM_URL=https://download.schedmd.com/slurm/slurm-17.11.6.tar.bz2  
  
# Build and install slurm  
RUN curl -fsL ${SLURM_URL} | tar xfj - -C /opt/ && \  
cd /opt/slurm-${SLURM_VER}/ && \  
./configure --sysconfdir=/etc/slurm && make && make install  
  
# Start with a Python image.  
FROM python:3.6-stretch  
LABEL maintainer="Brian May <brian@linuxpenguins.xyz>"  
  
# Install OS dependencies  
RUN apt-get update \  
&& apt-get install -y \  
gcc munge liblua5.3-0 \  
&& rm -rf /var/lib/apt/lists/*  
  
COPY \--from=slurm /usr/local /usr/local  
COPY start_slurm /usr/local/sbin  
  
ENV MUNGE_KEY_FILE ""  
ENV SLURM_UID ""  
VOLUME ["/etc/slurm", "/var/log"]  

