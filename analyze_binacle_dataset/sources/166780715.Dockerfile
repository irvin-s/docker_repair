FROM      ubuntu
MAINTAINER Politecnico di Torino

RUN apt-get update && apt-get install -y iptables

ADD sysctl.conf /etc/sysctl.conf
ADD ./start_nat.sh start_nat.sh

RUN chmod +x start_nat.sh

CMD ./start_nat.sh 2>&1 | tee nat.log
