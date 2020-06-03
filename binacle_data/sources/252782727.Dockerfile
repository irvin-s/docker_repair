FROM davedoesdev/rumprun-packages:publish-0.0.43  
RUN apt-get update -y && \  
apt-get install -y python-dev libffi-dev libssl-dev python-pip && \  
pip install python-dtuf  
COPY dtuf.sh /  
ENTRYPOINT ["/dtuf.sh"]  

