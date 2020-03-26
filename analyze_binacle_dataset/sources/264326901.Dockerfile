FROM ubuntu
RUN apt-get update;apt-get install curl libc6 gnupg2 sudo -y
RUN curl -L https://toolbelt.treasuredata.com/sh/install-ubuntu-bionic-td-agent3.sh | sh
RUN td-agent-gem install fluent-plugin-td fluent-plugin-s3 fluent-plugin-elasticsearch
ADD fluentd.conf /etc/td-agent/td-agent.conf
CMD sudo /etc/init.d/td-agent start; tail -f /dev/null
