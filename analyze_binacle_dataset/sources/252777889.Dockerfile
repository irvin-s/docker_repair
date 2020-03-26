FROM alpine:3.7  
ARG USER_KEY  
ARG HTTP_PROXY  
RUN test -n "$USER_KEY"  
RUN apk -U add \  
bash \  
git \  
htop \  
iptables \  
iputils \  
libltdl \  
lvm2 \  
mosh-server \  
ncdu \  
openssh-client \  
openssh-server \  
python3 \  
socat \  
tmux \  
util-linux \  
xz \  
file \  
gnupg \  
pv \  
e2fsprogs-extra \  
tcpdump \  
&& apk -qU fetch -s docker | tar -C / -xz usr/bin/docker \  
&& rm -rf /var/cache/apk/* \  
&& mkdir -p /root/.ssh \  
&& echo $USER_KEY >/root/.ssh/authorized_keys \  
&& pip3 --no-cache-dir install docker-compose  
ADD /rootfs/ /  
EXPOSE 22  
CMD /entrypoint.sh  

