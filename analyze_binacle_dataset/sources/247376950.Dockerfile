# use the latest nginx image
FROM nginx:1.11

# apt-get what we need
#RUN apt update && apt install -y \
#  telnet \
#  vim \
#  nano \
#  net-tools \
#  wget

# conf cp
COPY ./projects/robot-system/robot-nginx/template.nginx.conf /etc/nginx/nginx.conf

# root .bashrc
RUN echo "PS1='\[\e[31m\]\u\[\e[m\]@\h:\w\$ '" >> /root/.bashrc
RUN echo "alias ll='ls -la'" >> /root/.bashrc
RUN echo "export TERM=xterm" >> /root/.bashrc
