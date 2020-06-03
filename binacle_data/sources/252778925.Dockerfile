FROM debian:stretch  
  
LABEL Maintainer="Matt Burdan <burdz@burdz.net>"  
  
RUN apt update -y && \  
apt install sudo  
  
RUN echo "blog ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/blog  
  
RUN adduser blog  
RUN chown -R blog /home/blog  
RUN chown -R blog /usr/local  
  
USER blog  
WORKDIR /home/blog  
  
RUN sudo apt install -y \  
git \  
python-pip \  
python-dev \  
build-essential  
  
ADD . /tmp  
  
RUN pip install -r /tmp/requirements.txt --upgrade --user  
  
ENV PATH "$PATH:~/.local/bin"  

