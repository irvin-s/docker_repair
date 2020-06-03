FROM ubuntu:latest
ENV user=ezpwn
RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get install -y xinetd
RUN useradd -m $user
RUN echo "$user     hard    nproc       20" >> /etc/security/limits.conf
COPY ./add /home/$user/add
COPY ./ezpwnservice /etc/xinetd.d/ezpwnservice
RUN chown -R root:$user /home/$user
RUN chmod -R 750 /home/$user
#RUN chown root:$user /home/$user/flag
#RUN chmod 440 /home/$user/flag
EXPOSE 9993
CMD ["/usr/sbin/xinetd", "-d"]
