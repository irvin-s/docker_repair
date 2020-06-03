FROM alpine:3.5  
  
  
RUN adduser -D -u 1000 mail_man ;\  
mkdir /var/mail ;\  
mkdir /home/mail_man/.mutt ;\  
touch /var/mail/mail_man ;\  
chown mail_man /var/mail/mail_man ;\  
apk add \--no-cache mutt vim  
  
ADD muttrc /home/mail_man/.mutt/muttrc  
USER mail_man  
CMD ["mutt"]  

