FROM amonbase:latest

RUN apt-get update
RUN apt-get install -y --force-yes amon-agent mysql-server

ADD hosts /etc/amonagent/hosts
ADD mysql/mysql.yml /etc/amonagent/plugins/mysql/mysql.yml
ADD mysql/mysql.conf.example /etc/amonagent/plugins/mysql/mysql.conf.example

RUN ansible-playbook /etc/amonagent/plugins/mysql/mysql.yml -i /etc/amonagent/hosts -v

CMD ["/bin/bash"]