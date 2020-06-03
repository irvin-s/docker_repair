FROM python:3.4.3  
RUN pip install --upgrade pip  
RUN pip install pymysql  
RUN pip install requests  
RUN pip install beautifulsoup4  
  
RUN mkdir /home/python3  
  
WORKDIR /home/python3  

