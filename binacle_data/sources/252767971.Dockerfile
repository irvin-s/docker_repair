FROM ubuntu:14.04  
MAINTAINER Walter Moreira <wmoreira@tacc.utexas.edu>  
  
RUN apt-get update -y && \  
apt-get install -y python python-dev python-pip supervisor git curl  
RUN apt-get install -y libzmq-dev  
RUN pip install serf_master fig jinja2 ipython logbook ansible psutil  
WORKDIR /tmp  
RUN git clone https://github.com/waltermoreira/mischief.git  
WORKDIR /tmp/mischief  
RUN python setup.py install  
RUN curl -sSL https://get.docker.com/ubuntu/ | sudo sh  
RUN apt-get install -y sshpass  
RUN echo "[defaults]\nhost_key_checking = False" > /root/.ansible.cfg  
  
WORKDIR /  
COPY serf /usr/bin/  
COPY handler /handler  
COPY serfnode.conf /etc/supervisor/conf.d/  
COPY programs /programs  
COPY me.py /me  
COPY serfnode.yml /serfnode.yml  
COPY deploy /deploy  
COPY entry.sh /bin/entry.sh  
COPY out /out  
COPY err /err  
COPY alias.sh /alias  
  
EXPOSE 7946 7946/udp 7373  
RUN mkdir /serfnode  
VOLUME /serfnode  
  
#CMD ["/handler/entry.sh"]  
#CMD ["/deploy/deploy.py"]  
ENTRYPOINT ["/bin/entry.sh"]  

