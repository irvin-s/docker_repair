FROM python:3.6  
ADD . /code  
WORKDIR /code  
ENV PYTHONUNBUFFERED 0  
RUN pip install -r requirements.txt  
EXPOSE 5566  
EXPOSE 5577  
CMD [ "shoeboxmail" ]  

