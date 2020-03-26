FROM avatao/ubuntu:16.04  
  
# Install common packages  
RUN apt-get -qy update \  
&& apt-get -qy install \  
gdb \  
python-flask \  
python-tornado \  
python-yaml \  
python-zmq \  
python3-flask \  
python3-tornado \  
python3-yaml \  
python3-zmq \  
&& rm -rf /var/lib/apt/lists/*  
  
COPY . /  
  
# Install 3rd-party software  
RUN pip install capstone==3.0.4 \  
\  
&& cd /opt/ROPgadget \  
&& python setup.py install \  
&& python setup.py clean --all \  
\  
&& cd /opt/pwntools \  
&& python setup.py install \  
&& python setup.py clean --all \  
\  
&& chown -R user: /home/user /opt  
  
ENV CONTROLLER_PORT=5555 SECRET=test DEBUG=false TERM=xterm  
  
EXPOSE ${CONTROLLER_PORT}  
  
USER user  
  
CMD ["python3", "/opt/server.py"]  
  
# Add config.yml to retrieve flag in test function  
ONBUILD COPY config.yml /etc/  

