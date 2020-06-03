FROM ubuntu:latest
ENV user=alephuser
RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get install -y xinetd libc6:i386 libncurses5:i386 libstdc++6:i386
RUN useradd -m $user
RUN echo "$user     hard    nproc       20" >> /etc/security/limits.conf
COPY ./aleph /home/$user/aleph
COPY ./flag /home/$user/flag
COPY ./alephservice /etc/xinetd.d/alephservice
RUN chown -R root:$user /home/$user
RUN chmod -R 750 /home/$user
RUN chown root:$user /home/$user/flag
RUN chmod 440 /home/$user/flag
EXPOSE 31337
CMD ["/usr/sbin/xinetd", "-d"]
