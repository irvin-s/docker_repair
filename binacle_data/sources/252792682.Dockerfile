FROM python:3  
COPY requirements.txt /root/requirements.txt  
RUN pip install -r /root/requirements.txt \  
&& rm /root/requirements.txt  
  
COPY poker.py /usr/local/sbin/poker  
COPY static/* /usr/share/poker/  
  
ENTRYPOINT ["/usr/local/sbin/poker"]  

