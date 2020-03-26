# IMPORTANT NOTE ABOUT RUNNING THIS container  
# The sttrcancer.io domain was set up to use the IP range 172.17  
# which the docker daemon also wants to use by default.  
# In order to fix this, you have to modify the docker daemon  
# to use a different bridge IP (bip).  
# If you are on ubuntu, create a file called /etc/docker/daemon.json  
# and add this line (without leading comment) to it:  
# { "bip": "10.99.99.1/24" }  
# Then restart the docker daemon with the command:  
# service restart docker  
FROM ubuntu:16.04  
RUN apt-get update -y  
  
# python3-dev is needed to install pymongo from source  
# and thereby get the C extensions, for faster performance.  
RUN apt-get install -y python3 python3-dev python3-pip git  
  
RUN git clone https://github.com/dtenenba/oncoscape_plsr.git  
  
WORKDIR oncoscape_plsr  
  
RUN pip3 install -r requirements.txt  
  
EXPOSE 8000  
CMD ["./run.sh"]  

