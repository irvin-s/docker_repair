FROM python:2.7.10  
RUN pip install --upgrade pip  
RUN pip install pymysql  
RUN pip install requests  
RUN pip install beautifulsoup4  
  
RUN mkdir /home/python2  
  
WORKDIR /home/python2  

