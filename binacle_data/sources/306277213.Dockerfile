FROM swiftdocker/swift
MAINTAINER John Pope <jp at fieldstormapp dot com>

# Set Environment Variables & Language Environment
ENV HOME /root
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8


RUN apt-get update && apt-get -y install openssh-server supervisor unzip
RUN mkdir /var/run/sshd
RUN echo 'root:alpine' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Install Basic Packages
RUN apt-get install -y  unzip nano tmux colord zsh emacs


#install ZSH
RUN git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh \
      && cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc \
      && chsh -s /bin/zsh
RUN TERM=xterm-256color

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 22
CMD ["/usr/bin/supervisord"]
# CMD ["zsh"]
# docker build -t swift3-ssh .  
# https://github.com/swiftdocker/docker-swift/issues/9#issuecomment-162172540
# sudo docker run --security-opt seccomp=unconfined -p 2222:22 -i -t swift3-ssh 
# docker ps # find container id
# docker exec -i -t <containerid> /usr/bin/zsh

