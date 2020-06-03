FROM progrium/busybox  
RUN opkg-install bash coreutils-base64 openssh-client-utils openssh-client  
ENV SHELL /bin/bash  
ADD . setup  
WORKDIR setup  
RUN chmod +x *.sh  
CMD "./setup.sh"  

