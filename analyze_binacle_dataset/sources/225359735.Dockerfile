FROM ubuntu:17.04

RUN mkdir -p /root/.ssh \
 && touch /root/.ssh/id_rsa \
 && chmod 700 /root/.ssh/id_rsa \
 && apt-get update \
 && apt-get install -y autossh sshpass

# This copies over the autossh start script
ADD autossh.sh /autossh.sh
RUN chmod +x /autossh.sh

CMD ["/autossh.sh"]
