FROM python:2.7  
ADD requirements.txt /root/  
RUN pip install -r /root/requirements.txt  
ADD updater.py /usr/bin/route53-updater  
  
ENTRYPOINT ["/usr/bin/route53-updater"]

