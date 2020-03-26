FROM circleci/node:7.10  
COPY rancher.py /rancher.py  
RUN sudo apt install -y python-pip python-dev && \  
sudo pip install baker requests websocket  

