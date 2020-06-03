FROM ubuntu:trusty
ENV user=forestuser
RUN apt-get update
RUN apt-get install -y xinetd python cmake python-pip libglib2.0-dev git sudo
RUN useradd -m $user
RUN echo "$user     hard    nproc       20" >> /etc/security/limits.conf
COPY ./forest.py /home/$user/
COPY ./flag /home/$user/
COPY ./forestservice /etc/xinetd.d/
COPY ./make_unicorn.sh /opt/
COPY ./make_keystone.sh /opt/
RUN chown -R root:$user /home/$user
RUN chmod -R 750 /home/$user
RUN chown root:$user /home/$user/flag
RUN chmod 440 /home/$user/flag
RUN sh /opt/make_unicorn.sh
RUN sh /opt/make_keystone.sh
RUN mkdir /opt/eggcache
RUN chown -R $user:$user /opt/eggcache
EXPOSE 31337
CMD ["/usr/sbin/xinetd", "-d"]
