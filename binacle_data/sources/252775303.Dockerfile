FROM beevelop/base  
  
MAINTAINER Maik Hummel <m@ikhummel.com>  
  
RUN apt-get update -q && \  
apt-get install -y -q texlive-full biber gnuplot python-pygments && \  
apt-get clean && rm -rf /var/lib/apt/lists/*  
  
VOLUME /mnt/src  
  
ADD docker-entrypoint.sh /docker-entrypoint.sh  
  
ENTRYPOINT ["/docker-entrypoint.sh"]  

