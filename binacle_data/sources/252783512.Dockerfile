FROM python  
  
# Install Python requirements.  
COPY ./requirements.txt /root  
RUN pip install -r /root/requirements.txt  
  
ENV VDIRSYNCER_CONFIG "/vdirsyncer/config"  
VOLUME ["/vdirsyncer"]  
  
ENTRYPOINT ["vdirsyncer"]

