FROM ubuntu:14.10
RUN apt-get update -qq && apt-get upgrade -y \
    && apt-get install -y \
	build-essential \
	libpq-dev \
	libmcrypt-dev \
	libpng12-dev \
	libmysqlclient-dev \
	git \
	tig \
	curl \
	zsh \
	tmux \
	xclip \
	cmigemo \
	libmigemo-dev \
	editorconfig \
	jq \
	unar \
	silversearcher-ag \
	exuberant-ctags \
	vim-nox \
	ruby2.0 \
	python3-dev \
	python-dev \
	ruby2.0-dev \
	libperl-dev \
	golang \
	php5 \
	php5-common \
	php5-cli \
	php5-curl \
	php5-gd \
	php5-intl \
	php5-json \
	php5-mcrypt \
	php5-mysql \
	php5-sqlite \
	php5-xdebug \
	php5-xhprof \
	libluajit-5.1-dev \
	libssl-dev \
	libreadline-dev \
	libsqlite3-dev \
	libclang-dev \
	libxml2-dev \
	libmcrypt-dev \
	&& rm -rf /var/lib/apt/lists/*
 	# openssh-server \

	# vim-lua \
	# libcurl-dev \
	# libbiz2-dev \

RUN export uid=1000 gid=1000 && \
	mkdir -p /home/developer && \
	echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
	echo "developer:x:${uid}:" >> /etc/group && \
	echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
	echo 'developer:developer' | chpasswd && \
	chmod 0440 /etc/sudoers.d/developer && \
	chown ${uid}:${gid} -R /home/developer

	# mkdir -p /home/developer/.ssh && \
	# echo "" > /home/developer/.ssh/authorized_keys && \
	# chmod 0600 /home/developer/.ssh/authorized_keys && \

# USER developer
# ENV HOME /home/developer

# RUN curl -L https://raw.github.com/pekepeke/dotfiles/master/setup.sh | sh
# RUN vim -c "silent NeoBundleInstall" -c "quitall"

### apache2
# COPY 000-default.conf /etc/apache2/sites-enabled/000-default.conf
# RUN a2enmod ssl rewrite proxy_http php5 vhost_alias

# COPY httpd-foreground /usr/local/bin/

# EXPOSE 80
# CMD ["httpd-foreground"]

### sshd
# RUN mkdir /var/run/sshd
# RUN echo 'root:screencast' | chpasswd
# RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# # SSH login fix. Otherwise user is kicked off after login
# RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# ENV NOTVISIBLE "in users profile"
# RUN echo "export VISIBLE=now" >> /etc/profile

# EXPOSE 22
# CMD ["/usr/sbin/sshd", "-D"]
