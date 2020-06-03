FROM ubuntu:latest
ENV user=oracleuser
RUN apt-get update
RUN apt-get install -y xinetd python python-crypto
RUN useradd -m $user
RUN echo "$user     hard    nproc       20" >> /etc/security/limits.conf
COPY ./oracle.py /home/$user/oracle.py
COPY ./flag /home/$user/flag
COPY ./oracleservice /etc/xinetd.d/oracleservice
RUN chown -R root:$user /home/$user
RUN chmod -R 750 /home/$user
RUN chown root:$user /home/$user/flag
RUN chmod 440 /home/$user/flag
EXPOSE 31337
CMD ["/usr/sbin/xinetd", "-d"]
