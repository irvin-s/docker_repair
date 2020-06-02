FROM ruby:2.1  
MAINTAINER Oleks <oleks@oleks.info>  
  
RUN perl -pi -e 's/jessie/testing/g' /etc/apt/sources.list  
  
RUN DEBIAN_FRONTEND=noninteractive apt-get update \  
&& DEBIAN_FRONTEND=noninteractive apt-get upgrade -y \  
&& DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y \  
&& rm -rf /var/lib/apt/lists/*  
  
RUN DEBIAN_FRONTEND=noninteractive apt-get update \  
&& DEBIAN_FRONTEND=noninteractive apt-get install -y \  
python3-pip \  
texlive-full \  
&& rm -rf /var/lib/apt/lists/*  
  
RUN pip3 install Pygments  
  
RUN useradd --create-home --uid 1000 docker  
RUN chown -R docker:docker /home/docker  
USER docker  
  
WORKDIR /home/docker/  
  
CMD ["irb"]  

