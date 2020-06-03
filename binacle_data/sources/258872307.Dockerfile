FROM osrg/dind-ubuntu-vivid
MAINTAINER Akihiro Suda <suda.akihiro@lab.ntt.co.jp>

# Install OVS
RUN apt-get update && apt-get install -y openvswitch-switch

# Install Python packages
RUN bash -c 'apt-get install -y python-{colorama,dev,eventlet,lxml,msgpack,netaddr,networkx,oslo.config,paramiko,pip,routes,six,webob}'

# Install Ryu
RUN pip install ryu

# Install pipework
RUN apt-get install -y arping
RUN wget --no-check-certificate --quiet https://raw.githubusercontent.com/jpetazzo/pipework/master/pipework -O /usr/local/bin/pipework
RUN chmod +x /usr/local/bin/pipework

# Install misc useful stuffs
RUN apt-get install -y less lv netcat telnet bash-completion vim byobu

# Install init
ADD ./init.dind-ovs-ryu.sh /init.dind-ovs-ryu.sh
RUN chmod +x /init.dind-ovs-ryu.sh
CMD ["wrapdocker", "/init.dind-ovs-ryu.sh"]
