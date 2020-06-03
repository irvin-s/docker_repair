FROM python:3.5.2  
MAINTAINER Brian Williams  
  
RUN git clone https://github.com/Brian-Williams/acceptanceutils \  
&& pip3 install acceptanceutils/ \  
&& rm -r acceptanceutils/  

