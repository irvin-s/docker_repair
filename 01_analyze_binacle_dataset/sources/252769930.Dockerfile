FROM ubuntu:16.04  
MAINTAINER Arseniy Shestakov <me@arseniyshestakov.com>  
  
# Install the python script required for "add-apt-repository"  
RUN apt-get update && apt-get install -y software-properties-common  
  
# Add daily builds PPA and install VCMI  
RUN add-apt-repository -y ppa:vcmi/ppa \  
&& apt-get update \  
&& apt-get install -y vcmi wget unar unzip \  
&& apt-get clean all  
  
# Create user for server and some directories  
RUN useradd vcmi --home /vcmi --create-home \  
&& mkdir -p /vcmi/.local/share/vcmi/ \  
&& mkdir -p /vcmi/.config/vcmi/  
  
# Create symbolic links to the host volume directories  
RUN ln -s "/mnt/Data" "/vcmi/.local/share/vcmi/" \  
&& ln -s "/mnt/Maps" "/vcmi/.local/share/vcmi/" \  
&& ln -s "/mnt/Mods" "/vcmi/.local/share/vcmi/" \  
&& ln -s "/mnt/modSettings.json" "/vcmi/.config/vcmi/"  
  
COPY run.sh /vcmi/run.sh  
RUN chmod +x /vcmi/run.sh  
  
RUN chown -R vcmi:vcmi /vcmi  
  
USER vcmi  
WORKDIR /vcmi  
  
EXPOSE 3030/tcp  
CMD ["/vcmi/run.sh"]  

