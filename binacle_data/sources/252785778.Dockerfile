FROM ditacommunity/dita-ot-base  
# Make the whole OT itself available  
USER root  
VOLUME /opt/dita-ot/DITA-OT  
VOLUME /opt/dita-ot/userdata  
VOLUME /opt/dita-ot/out  
#  
# End of Dockerfile  
#

