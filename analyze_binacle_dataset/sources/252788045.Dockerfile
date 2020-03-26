FROM python:3  
MAINTAINER crazybit <crazybit.github@gmail.com>  
  
RUN pip install autobahn requests pycrypto numpy prettytable  
RUN git clone https://github.com/xeroc/python-graphenelib  
  
WORKDIR python-graphenelib  
RUN python3 setup.py install  
  
## Mount external data into the container  
VOLUME ["/conf"]  
  
ADD docker/start.py /start.py  
  
CMD [ "python", "/start.py" ]  

