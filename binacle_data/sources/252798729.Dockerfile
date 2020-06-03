FROM ubuntu  
  
LABEL Author="desertraider"  
  
RUN apt update && apt install rsync -y  
RUN apt install sshpass -y  
RUN mkdir /root/.ssh/ && touch /root/.ssh/known_hosts  
COPY rsync-bash /  
COPY chown /  
RUN chmod +x /rsync-bash  
RUN chmod +x /chown  
RUN cd / && ls  
ENTRYPOINT [ "/rsync-bash" , "-D", "FOREGROUND"]

