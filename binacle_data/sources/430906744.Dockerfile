FROM amonbase:latest

RUN apt-get update
RUN apt-get install -y --force-yes amon-agent mongodb-server

ADD hosts /etc/amonagent/hosts
ADD mongo/mongo.yml /etc/amonagent/plugins/mongo/mongo.yml
ADD mongo/mongo.conf.example /etc/amonagent/plugins/mongo/mongo.conf.example

RUN service mongodb start

RUN ansible-playbook /etc/amonagent/plugins/mongo/mongo.yml -i /etc/amonagent/hosts -v

CMD ["/bin/bash"]