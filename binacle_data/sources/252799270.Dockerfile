# Use ubuntu image as parent  
FROM debian:stretch-slim  
  
# Update and install components  
RUN apt-get update \  
&& apt-get -y install \  
bootp \  
mksh \  
rsh-redone-server \  
tftpd \  
xinetd \  
&& rm -rf /var/lib/apt/lists  
  
VOLUME /DIST  
  
# Create guest user  
RUN useradd -c "Guest User" \  
-d /home/guest -m \  
-s /bin/mksh guest  
  
# Set root's shell to mksh  
RUN usermod -s /bin/mksh root  
  
# Clear password on root and guest user  
RUN passwd -d root  
RUN passwd -d guest  
  
# Set kernel tunables for connecting IRIX machines  
# RUN sysctl net.ipv4.ip_no_pmtu_disc=1  
# Limit port reply range to < 32768 for tftp  
# RUN sysctl net.ipv4.ip_local_port_range="2048 32767"  
# Set .rhosts for root and guest  
RUN echo "iris root" > /root/.rhosts  
RUN echo "iris root" > /home/guest/.rhosts  
  
# Put a default bootptab for bootps  
COPY bootptab /etc/bootptab  
  
# Copy the xinetd daemon configuration files  
COPY bootps /etc/xinetd.d/bootps  
COPY tftp /etc/xinetd.d/tftp  
COPY rsh /etc/xinetd.d/rsh  
  
# Make bootps port available to the world outside this container  
EXPOSE 67  
# Make tftp ports available to the world outside this container  
EXPOSE 69  
EXPOSE 2048-32767  
# Make rsh port available to the world outside this container  
EXPOSE 514  
# use the xinetd super server as entrypoint  
ENTRYPOINT ["/usr/sbin/xinetd"]  
CMD ["-d","-dontfork"]  

