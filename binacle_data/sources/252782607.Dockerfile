FROM python:2.7  
ENV PYTHONUNBUFFERED 1  
ENV PYTHONPATH /code  
  
RUN mkdir /code  
WORKDIR /tmp  
#RUN wget https://bootstrap.pypa.io/get-pip.py  
#RUN python get-pip.py  
WORKDIR /code  
RUN mkdir -p /src/python  
COPY requirements.txt /code/  
COPY . /code  
  
RUN pip install --upgrade pip  
RUN pip install --src=/src/python -r requirements.txt  
  
#Development  
#RUN apt-get install vim  
WORKDIR /code/  

