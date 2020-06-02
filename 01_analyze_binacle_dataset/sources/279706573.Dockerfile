FROM gcr.io/tensorflow/tensorflow:1.3.0-gpu-py3

# Setup ssh server
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:sshtest' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# CUDA environment is not passed by default to the SSH session. One has to export it in /etc/profile/ 
RUN echo "export PATH=$PATH" >> /etc/profile && \
    echo "ldconfig" >> /etc/profile

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
