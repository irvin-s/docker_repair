FROM alpine:3.7  
# Install openssh  
RUN apk --update add openssh \  
&& rm -f /var/cache/apk/*  
  
# Only use host keys with good crypto algorithms.  
RUN cd /etc/ssh \  
&& rm -f ssh_host_*key* \  
&& ssh-keygen -t ed25519 -f ssh_host_ed25519_key -N "" < /dev/null \  
&& ssh-keygen -t rsa -b 4096 -f ssh_host_rsa_key -N "" < /dev/null  
  
# Copy in our hardened sshd config and moduli.  
COPY sshd_config /etc/ssh/sshd_config  
COPY moduli.safe /etc/ssh/moduli  
  
# Create our non-privileged user.  
RUN adduser -D bellhop \  
&& passwd -d bellhop \  
&& mkdir /home/bellhop/.ssh \  
&& chown bellhop:nogroup /home/bellhop/.ssh \  
&& chmod 700 /home/bellhop/.ssh  
  
# Allow our non-privileged user to access ssh configs.  
RUN chown -R bellhop:nogroup /etc/ssh \  
&& chmod 700 /etc/ssh \  
&& chmod 600 /etc/ssh/*  
  
# Run hardening script.  
ADD harden.sh /usr/sbin/harden.sh  
RUN sh /usr/sbin/harden.sh  
  
# Make our non-privileged user's .ssh directory a volume.  
VOLUME /home/bellhop/.ssh  
  
# Run sshd as our non-privileged user.  
USER bellhop  
CMD ["/usr/sbin/sshd", "-D"]  

