# docker image for the splayd (splay daemon)
# build from the splay src folder with: docker build -t splay-project/ubuntu-splayd .
FROM	ubuntu:14.04.2
# install dependencies
RUN		apt-get update && apt-get install -y git build-essential libreadline-dev \ 
											 libncurses5-dev lua5.1 liblua5.1-0 \
											 liblua5.1-0-dev lua-socket lua-socket-dev \
											 libssl-dev lua-sec lua-sec-dev openssl \
		--no-install-recommends \
		&& rm -rf /var/lib/apt/lists/*
# copy the source code for the daemon
COPY	external_libs /splay/src/external_libs
COPY	daemon /splay/src/daemon
# set env variables
ENV LUA_PATH /root/local/lualibs/lib/?.lua;/usr/local/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?/init.lua;/usr/local/lib/lua/5.1/?.lua;/usr/local/lib/lua/5.1/?/init.lua;/usr/share/lua/5.1/?.lua;/usr/share/lua/5.1/?/init.lua
ENV LUA_CPATH /root/local/lualibs/clib/?.so;/usr/local/lib/lua/5.1/?.so;/usr/lib/x86_64-linux-gnu/lua/5.1/?.so;/usr/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/loadall.so
# compile splay
WORKDIR	/splay/src/external_libs/lua-5.1.4/
RUN		make linux
WORKDIR	/splay/src/daemon/
RUN 	make
# install splay
WORKDIR /splay/src/daemon/
RUN		./install.sh
# no port used by the splayd
# EXPOSE 22000
# remove the two lines at the end of the settings.lua
RUN		cat settings.lua | sed '$d' | sed '$d' > settings.lua
CMD		["./splayd"]
