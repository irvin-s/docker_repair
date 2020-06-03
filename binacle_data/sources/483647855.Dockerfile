FROM martinrusev/centos:latest

ADD install_agent.sh /var/install_agent.sh
RUN SERVER_KEY=341cfc47fe3557bb891967f680b41bf9 sh -c /var/install_agent.sh
RUN cat /etc/amon-agent.conf

CMD ["/bin/bash"]