FROM williamyeh/ansible:1.9-debian8-onbuild  
COPY playbook.yml /  
  
ENV HOST $HOST  
ENV SUDO_PASSWORD $SUDO_PASSWORD  
  
CMD ansible-playbook -vvv -i $HOST, playbook.yml  

