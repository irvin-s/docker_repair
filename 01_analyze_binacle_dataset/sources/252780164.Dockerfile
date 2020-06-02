FROM azathoth/python:2  
RUN pip install enum numpy matplotlib Pillow scipy  
  
COPY ./LKH/install.sh /opt/LKH/install.sh  
  
RUN chmod +x /opt/LKH/install.sh  
  
RUN cd /opt/LKH && /opt/LKH/install.sh  
  
ENV DISPLAY 10.0.75.1:0.0  
EXPOSE 19997  

