FROM ubuntu:latest  
ENV REFRESHED_AT 2017-12-11  
LABEL maintainer="Matthieu Boileau <matthieu.boileau@math.unistra.fr>"  
  
RUN apt-get update --fix-missing && \  
apt-get install -y \  
pandoc \  
texlive-xetex \  
texlive-fonts-extra \  
texlive-math-extra && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
RUN useradd -m -s /bin/bash euler  
ENV HOME /home/euler  
RUN chown -R euler:euler /home/euler  
USER euler  
WORKDIR $HOME  
  
CMD /bin/bash  

