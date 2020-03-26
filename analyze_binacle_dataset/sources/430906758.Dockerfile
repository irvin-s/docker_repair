FROM amonbase:latest

RUN apt-get install -y --force-yes amon-agent nginx


RUN /etc/init.d/amon-agent status

ADD hosts /etc/amonagent/hosts
ADD nginx/nginx.yml /etc/amonagent/plugins/nginx/nginx.yml
ADD nginx/nginx.conf.example /etc/amonagent/plugins/nginx/nginx.conf.example
ADD nginx/status_template /etc/amonagent/plugins/nginx/status_template

RUN ansible-playbook /etc/amonagent/plugins/nginx/nginx.yml -i /etc/amonagent/hosts -v

CMD ["/bin/bash"]