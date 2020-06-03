FROM python:3.6  
MAINTAINER AHAPX  
MAINTAINER anarchy.b@gmail.com  
  
RUN git clone https://github.com/AHAPX/LibertatemBot.git /bot  
RUN pip install -U pip  
RUN pip install -r /bot/requirements.txt  
  
VOLUME /bot/src/  
WORKDIR /bot/src/  
  
CMD python main.py  

