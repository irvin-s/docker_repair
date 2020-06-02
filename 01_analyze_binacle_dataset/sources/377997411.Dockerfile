FROM base
MAINTAINER Jacques Fuentes

RUN apt-get install -y openssh-server

RUN sed -e 's/#RSAAuthentication.*$/RSAAuthentication yes/'
RUN mkdir /root/.ssh
RUN mkdir /var/run/sshd
# NOTE: change this key to your own
ADD sshkey.pub /root/.ssh/authorized_keys
RUN chown root:root /root/.ssh/authorized_keys

RUN useradd --create-home --home-dir /home/git git
RUN mkdir /home/git/.ssh
ADD sshkey.pub /home/git/.ssh/authorized_keys

RUN mkdir -p /srv/deployer
RUN cd /srv/deployer && git init --bare
RUN cd /srv/deployer && git config receive.denyCurrentBranch ignore
RUN cd /srv/deployer && git config --bool receive.denyNonFastForwards false
ADD post-receive.sh /srv/deployer/hooks/post-receive

ADD serf.json /etc/serf/config.json
ADD supervisord.conf /etc/supervisord/conf.d/supervisord.conf

EXPOSE 22 7946

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord/conf.d/supervisord.conf"]
