FROM ubuntu:16.04

# Base Docker for unpriviledge SSH
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN mkdir /home/challenge/
RUN useradd -d /home/challenge/ -s /bin/bash challenge
RUN echo 'challenge:password' | chpasswd
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
RUN echo "AllowUsers challenge" >> /etc/ssh/sshd_config

# Target victim of the challenge
RUN useradd admin
RUN apt-get install -y sudo vim

# Faulty permission
RUN echo "challenge ALL=(admin) NOPASSWD: /usr/bin/vi /home/admin/message.txt" >> /etc/sudoers
RUN mkdir /home/admin/
RUN echo "Please edit me" >> /home/admin/message.txt
RUN echo "FLAG-b13886a1ff3d93049b967b10ba69b413" >> /home/admin/flag.txt
RUN chmod 640 /home/admin/flag.txt
RUN chown root:admin /home/admin/flag.txt

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
