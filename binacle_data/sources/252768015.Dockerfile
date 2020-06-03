FROM ghost  
  
# Install openssh for web-ssh access from kudu  
RUN apt-get update && apt-get install \  
\--no-install-recommends --no-install-suggests -y \  
openssh-server \  
supervisor \  
git \  
&& echo "root:Docker!" | chpasswd  
  
# Creating folder so that image won't fail in non-azure  
RUN mkdir -p /home/LogFiles  
  
# Copy config and shell scripts to the right place  
COPY sshd_config /etc/ssh/  
COPY init-container.sh /bin/  
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf  
  
# Expose the port for ssh access from kudu  
EXPOSE 2222  
CMD ["/bin/init-container.sh"]

