FROM blankoninfra/lucid  
RUN mkdir /var/cache/apt/archives/partial && \  
apt-get install -y python-pip  
ADD v1.0.tar.gz /opt  
RUN mv /opt/aku-boi-1.0 /opt/aku && \  
cd /opt/aku && \  
pip install -r requirements.txt  
ADD run.sh /root  
EXPOSE 8081  
CMD ["/bin/bash","/root/run.sh"]

