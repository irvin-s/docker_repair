FROM doomhammer/pandoc  
MAINTAINER Piotr Gaczkowski <DoomHammerNG@gmail.com>  
  
RUN apt-get update && \  
apt-get install -qqy \  
python-pip && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/*  
  
RUN pip install pandocfilter-pygments  
  
ENTRYPOINT [ "/usr/bin/pandoc" ]  

