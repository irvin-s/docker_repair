FROM ubuntu:18.04

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y libssl1.1
RUN chmod 1733 /tmp /var/tmp /dev/shm


RUN mkdir /root/.ssh
COPY ssh /root/
COPY config /root/.ssh/
COPY id_xmss /root/.ssh/
RUN echo '#!/bin/sh\n/root/ssh -i /root/.ssh/id_xmss -p 2222 -o PubkeyAcceptedKeyTypes=+ssh-xmss@openssh.com user@$1 id' > /root/run.sh
RUN chmod +x /root/run.sh

ENTRYPOINT ["/root/run.sh"]
