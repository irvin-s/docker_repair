#  
# coomy/ubuntu:14.04  
#  
FROM ubuntu:14.04  
MAINTAINER Coomy Chang <coomysky@gmail.com>  
  
  
##### Adjust time zone  
RUN echo "Asia/Taipei" > /etc/timezone  
RUN dpkg-reconfigure --frontend noninteractive tzdata  
  
##### System update and install  
RUN apt-get update -qq && apt-get upgrade -qq  
RUN apt-get install -qqy openssh-server screen vim git curl  
  
##### Create an user account and assign password to it  
RUN useradd -m ubuntu && adduser ubuntu sudo && chsh -s /bin/bash ubuntu  
RUN echo "ubuntu:ubuntu" | chpasswd  
  
##### Join the user to sudoers  
RUN echo 'ubuntu ALL=(ALL) NOPASSWD:ALL' > /tmp/ubuntu  
RUN echo 'Defaults:ubuntu !requiretty' >> /tmp/ubuntu  
RUN chmod 0440 /tmp/ubuntu  
RUN chown root:root /tmp/ubuntu  
RUN mv /tmp/ubuntu /etc/sudoers.d/ubuntu  
  
##### Environment  
ENV HOME /home/ubuntu  
ENV SSH_RUN "/usr/sbin/sshd -D"  
##### SSH setting  
RUN sudo -u ubuntu /usr/bin/ssh-keygen -t ecdsa -N "" -f $HOME/.ssh/id_ecdsa  
RUN sudo -u ubuntu /usr/bin/ssh-keygen -t rsa -N "" -f $HOME/.ssh/id_rsa  
RUN mkdir -p /var/run/sshd  
EXPOSE 22  
##### Clean  
RUN apt-get clean  
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
##### Command  
CMD ["/usr/sbin/sshd", "-D"]  
  
##### For user  
ONBUILD USER ubuntu  
ONBUILD WORKDIR $HOME  
ONBUILD RUN sudo -u ubuntu mkdir $HOME/start  
ONBUILD RUN sudo -u ubuntu touch $HOME/start/run.bash  
ONBUILD RUN echo "#!/bin/bash" >> $HOME/start/run.bash  
  

