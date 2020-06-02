FROM tsutomu7/scientific-python  
ENV PYTHONUNBUFFERED 1  
RUN sudo mkdir /code  
WORKDIR /code  
ADD . /code/  

