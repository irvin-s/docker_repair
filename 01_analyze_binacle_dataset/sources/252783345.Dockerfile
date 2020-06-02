FROM debian:9  
RUN apt-get update && apt-get -y install \  
sudo \  
systemd \  
python-pip \  
python-dev \  
curl \  
&& apt-get clean  
  
ADD dbus.service /etc/systemd/system/dbus.service  
RUN systemctl enable dbus.service  
  
# fix "mesg: ttyname failed: Inappropriate ioctl for device" warning  
RUN cp /etc/profile /root/.profile  
  
RUN pip install ansible ansible-lint  
RUN curl -fsSL https://goss.rocks/install | sh  
  
WORKDIR /ansible  
  
CMD ["/lib/systemd/systemd"]  

