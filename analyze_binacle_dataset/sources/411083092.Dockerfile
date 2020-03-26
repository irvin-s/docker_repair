FROM base/archlinux
MAINTAINER Dusan <dusan@floorplanner.com>

# Runs whole system upgrade and install packages
RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm base-devel binutils curl python2 python2-pip cronie

# Builds & Installs RabbitMQ server package from AUR
WORKDIR /tmp
RUN curl -O https://aur.archlinux.org/packages/ra/rabbitmq/rabbitmq.tar.gz
RUN tar -xzf rabbitmq.tar.gz
WORKDIR /tmp/rabbitmq
RUN makepkg --asroot --noconfirm --syncdeps --install
RUN rabbitmq-plugins enable rabbitmq_management
WORKDIR /root
RUN rm -rf /tmp/rabbitmq

# Installs Configuration Synchronization service
RUN pip2 install python-etcd==0.3.0
RUN pip2 install urllib3==1.8.2
RUN pip2 install pyrabbit==1.0.1

# Add and run scripts
ADD configure.sh /configure.sh
RUN chmod 755 /configure.sh
RUN /configure.sh
ADD configsync.py /configsync.py
RUN chmod 755 /configsync.py
ADD run.sh /run.sh
RUN chmod 755 /run.sh
ADD logrotate.cron /etc/cron.daily/logrotate
RUN chmod 755 /etc/cron.daily/logrotate
ADD rabbitmq.logrotate /etc/logrotate.d/rabbitmq

# RabbitMQ ports
EXPOSE 5672 15672

CMD ["/run.sh"]

