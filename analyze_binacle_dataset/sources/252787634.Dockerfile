FROM python:2.7  
RUN apt-get update && apt-get install -y cron  
RUN pip install synapseclient  
RUN pip install --pre github3.py  
COPY crontab /etc/cron.d/importissues-cron  
RUN chmod 644 /etc/cron.d/importissues-cron  
RUN /usr/bin/crontab /etc/cron.d/importissues-cron  
CMD cron -f  
COPY importissues.py /importissues.py  

