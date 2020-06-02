FROM golang:1.10.2
LABEL description="golang, gb ad a vim working environment"
MAINTAINER mowings@turbosquid.com
RUN go get github.com/constabulary/gb/...
VOLUME /app
ENV GOPATH=/app:/app/vendor
# Sets up my working env. YMMV
ENV TERM=xterm-256color
RUN apt-get -y update && apt-get -y install git vim wget tmux locales
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen
RUN cd /root && wget -q -O - https://gist.githubusercontent.com/mowings/1832c5acea6084e84ed9051edca42c36/raw/d51fda6b46f19fca603680368fe78756a5ae9395/setup.sh | /bin/bash
RUN cd /root && wget -q https://gist.githubusercontent.com/mowings/1832c5acea6084e84ed9051edca42c36/raw/d51fda6b46f19fca603680368fe78756a5ae9395/.vimrc
RUN cd /root && wget -q https://gist.githubusercontent.com/mowings/1832c5acea6084e84ed9051edca42c36/raw/d51fda6b46f19fca603680368fe78756a5ae9395/.tmux.conf
RUN echo >> /root/.vimrc && echo "set t_ut=" >> /root/.vimrc
RUN apt-get update
RUN apt-get install  -y curl sudo
COPY docker/sudoers /etc/sudoers
RUN useradd -d /home/scylla -U -m -s /bin/bash scylla  && usermod -a -G sudo scylla -p '*'
RUN mkdir /home/scylla/.ssh
RUN ssh-keygen -N ""  -f scylla && cp scylla.pub /home/scylla/.ssh/authorized_keys && scp scylla /home/scylla/.ssh && \
    chown scylla:scylla /home/scylla
COPY notifiers /usr/local/scyd/notifiers
RUN chmod 600 /home/scylla/.ssh/scylla
RUN apt-get -y install openssh-server && mkdir /var/run/sshd
WORKDIR /app
COPY docker/start.sh  /start.sh
CMD  /start.sh
