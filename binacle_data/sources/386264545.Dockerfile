# --------------------------------------------------------------------
#  Nginx + NodeJS server, and SSHD, with supervisord
#
# * Nginx server is listening to port 80
# * Node server is accessible at port 8080
# * All servers are started and controlled by supervisord
# * Login authentication by public-key (my-ssh-key.pub)
# * Logrotate periodically checks and rotates nginx access logfile
# --------------------------------------------------------------------

FROM            fedora
MAINTAINER      Misho Krastev <misho.kr@gmail.com>

# Install ---------------------------------

RUN yum install -y nodejs npm nginx openssh-server supervisor logrotate

# Configure SSH ---------------------------

RUN ssh-keygen -t rsa   -b 2048 -f /etc/ssh/ssh_host_rsa_key -N "" && \
    ssh-keygen -t ecdsa -b  521 -f /etc/ssh/ssh_host_ecdsa_key -N ""

ADD nginx-nodejs-server.pubkey  /root/.ssh/authorized_keys
RUN chown root:root             /root/.ssh/authorized_keys && \
    chmod 600		            /root/.ssh/authorized_keys

# Configure NodeJS app --------------------

ADD app /src
RUN cd /src && npm install

# Configure Nginx -------------------------

RUN cp /etc/nginx/nginx.conf{,.original}
ADD nginx.conf          /etc/nginx/

# Configure logrotate ---------------------

ADD logrotate.nginx.conf    /etc/logrotate.d/nginx
ADD logrotate-loop.sh      	/usr/bin/logrotate-loop

RUN chmod 644               /etc/logrotate.d/nginx && \
    chown root:root	        /etc/logrotate.d/nginx

# RUN cat /etc/supervisord.logrotate.conf >> /etc/supervisord.conf && rm /etc/supervisord.logrotate.conf

# Configure Supervisord -------------------

ADD supervisord.conf          	/etc/supervisord.conf
ADD supervisord.sshd.conf       /etc/supervisord.d/
ADD supervisord.nodejs.conf     /etc/supervisord.d/
ADD supervisord.nginx.conf      /etc/supervisord.d/
ADD supervisord.logrotate.conf	/etc/supervisord.d/

# Run -------------------------------------

ENV PORT	8080

EXPOSE 22 80 8080

CMD [ "/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf" ]

# --------------------------------------------------------------------
# EOF
