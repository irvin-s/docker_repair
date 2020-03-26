#************************ Spotagory Background job runner  
#  
######################################################################  
  
FROM python:2.7  
  
MAINTAINER Adebanjo Inioluwa  
  
ONBUILD RUN apt-get update  
ONBUILD RUN apt-get upgrade -y  
  
RUN pip install pika  
RUN pip install cql  
RUN pip install uuid  
  
# add dashboard directory to app  
  
COPY background /app  
  
#WORKDIR /app  
CMD ["python" ,"/app/friends_timeline_addpost.py &"]  
CMD ["python" ,"/app/friends_timeline_followuser.py &"]  
CMD ["python" ,"/app/friends_timeline_unfollowuser.py &"]  
CMD ["python" ,"/app/send_forgot_password_mail_to_user.py &"]  
CMD ["python" ,"/app/send_invitation_mails_to_users.py &"]  
CMD ["python" ,"/app/send_mail_to_registered_user.py &"]  

