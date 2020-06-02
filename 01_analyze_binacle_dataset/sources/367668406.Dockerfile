FROM python:3.5.1

RUN echo "eval \$(ssh-agent -s) >> /dev/null" >> /root/.bashrc
RUN echo "trap 'kill \$SSH_AGENT_PID' EXIT" >> /root/.bashrc

RUN apt-get update
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -
RUN apt-get install -qqy nodejs
RUN apt-get install -qqy build-essential

RUN npm install azure-cli -g
RUN azure telemetry --disable
RUN azure config mode arm

RUN curl -sSL https://get.docker.com/ | sh
RUN curl -L https://github.com/docker/compose/releases/download/1.7.1/docker-compose-`uname -s`-`uname -m` > docker-compose; mv docker-compose /usr/local/bin/docker-compose; chmod +x /usr/local/bin/docker-compose

COPY config /root/.acs

COPY . src

WORKDIR src

RUN pip install -e .
RUN pip install -e .[test]
RUN python setup.py install

ENTRYPOINT bash
