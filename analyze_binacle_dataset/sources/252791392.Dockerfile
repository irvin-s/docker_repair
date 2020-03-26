# FROM dita4publishers/dita-ot-base:1.8.5  
FROM ditaot/dita-ot-base:latest  
#  
# DITA for Small Teams OT container.  
# This is basically an unmodified clone of the  
# DITA for Publishers image so we have access  
# to all the D4P transforms and vocabulary (EPUB,  
# HTML5, etc.).  
#  
# You can use this image or any of the other DITA-OT  
# images as your OT image as long as the set of  
# volumes it exposes is the same. In particular,  
# both the BaseX and GitLab containers need to have  
# an /opt/dita-ot/DITA-OT volume available.  
#  
# End of Dockerfile  
#  

