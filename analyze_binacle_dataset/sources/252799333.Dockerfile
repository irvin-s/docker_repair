FROM telegraf  
  
RUN apt-get update &&\  
apt-get install -y \  
ipmitool \  
jq \  
lm-sensors \  
python-dev \  
python-pip && \  
pip install ouimeaux  
  
EXPOSE 8125/udp 8092/udp 8094  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["telegraf"]  

