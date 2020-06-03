FROM ubuntu  
  
LABEL Author="desertraider"  
  
RUN apt update && apt install rsync -y  
RUN apt install mysql-client -y  
RUN apt install sshpass -y  
RUN mkdir /root/.ssh/ && touch /root/.ssh/known_hosts  
COPY rsync-bash /  
RUN chmod +x /rsync-bash  
ENTRYPOINT [ "/rsync-bash" , "-D", "FOREGROUND"]

