#################################################################  
#  
# ## .  
# ## ## ## ==  
# ## ## ## ## ===  
# /""""""""""""""""\\___/ ===  
# ~~~ {~~ ~~~~ ~~~ ~~~~ ~~ ~ / ===- ~~~  
# \\______ o __/  
# \ \ __/  
# \\____\\______/  
#  
#################################################################  
  
FROM scratch  
MAINTAINER Chris Moore <chris@cloudspace.com>  
  
  
ADD go-apns /go-apns  
  
#CMD apt-get install ca-certificates  
  
#COPY userkey.pem /usr/share/ca-certificates  
#COPY usercert.pem /usr/share/ca-certificates  
  
#CMD chmod 0400 /usr/share/ca-certificates/userkey.pem  
#CMD chmod 0400 /usr/share/ca-certificates/usercert.pem  
  
#CMD dpkg-reconfigure ca-certificates  
  
#CMD update-ca-certificates  
  

