FROM phusion/baseimage:0.9.22  
MAINTAINER AiiDA Team <info@aiida.net>  
  
# Set correct environment variables.  
ENV HOME /root  
  
# Use baseimage-docker's init system.  
CMD ["/sbin/my_init"]  
  
# TODO: probably postgresql-server-dev-9.5 are needed only during  
# the pip install phase, so could be removed afterwards (and maybe  
# used in the same layer)  
# install required software  
RUN apt-get update \  
&& apt-get -y install \  
git \  
openssh-client \  
postgresql-client-9.5 \  
postgresql-server-dev-9.5 \  
python2.7 \  
&& apt-get -y install \  
python-pip \  
ipython \  
python2.7-dev \  
&& rm -rf /var/lib/apt/lists/* \  
&& apt-get clean all  
  
# update pip and setuptools, required for AiiDA  
RUN pip install -U pip setuptools  
  
# add USER (no password)  
RUN useradd -m -s /bin/bash aiida  
  
##########################################  
############ Installation Setup ##########  
##########################################  
# install rest of the packages as normal user  
USER aiida  
  
# set $HOME, create git directory  
ENV HOME /home/aiida  
  
RUN mkdir -p $HOME/code/  
WORKDIR /home/aiida/code  
  
## Get latest release from git  
RUN git clone https://github.com/aiidateam/aiida_core.git && \  
cd aiida_core && \  
git checkout v0.11.2 && \  
cd ..  
  
## Alternatively, use wget  
#RUN wget --no-check-certificate -q \  
# https://github.com/aiidateam/aiida_core/archive/develop.tar.gz && \  
# tar xzf develop.tar.gz && \  
# rm develop.tar.gz && \  
# mv aiida_core-develop aiida_core  
WORKDIR /home/aiida  
# make ssh dir and create host entry for bitbucket.org  
RUN mkdir $HOME/.ssh/ && \  
touch $HOME/.ssh/known_hosts  
  
# verdi auto-complete to bashrc - currently disabled  
#RUN echo 'eval "$(verdi completioncommand)"' >> $HOME/.bashrc  
# Add the bin folder to the path (e.g. for verdi) so that  
# it works also from non-login shells  
RUN echo 'export PATH=~/.local/bin:$PATH' >> $HOME/.bashrc  
  
# Install AiiDA  
WORKDIR /home/aiida/code/aiida_core  
RUN pip install --user -U pip wheel setuptools && pip install --user -e .  
  
# Important to end as user root!  
USER root  

