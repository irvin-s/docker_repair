FROM python  
RUN pip install requests  
RUN apt update  
RUN apt-get install -y vim  
ADD skynet-terminator.py /root/skynet-terminator.py  
CMD python /root/skynet-terminator.py  

