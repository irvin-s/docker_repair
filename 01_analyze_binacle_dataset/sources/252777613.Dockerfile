FROM ubuntu:xenial  
  
RUN apt update \  
&& apt install -y \  
git \  
python \  
python-setuptools \  
python-pip  
  
RUN useradd -ms /bin/bash -u 1001 steam  
  
RUN cd /home/steam \  
&& git clone https://github.com/Snepsts/Ice \  
&& cd Ice \  
&& python setup.py install \  
&& chown -R steam:steam /home/steam/Ice  
  
USER steam  
  
RUN mkdir -p /home/steam/.local/share  
  
WORKDIR '/home/steam/Ice'  
  
ENTRYPOINT /usr/bin/python -m ice  
CMD ["-h"]  

