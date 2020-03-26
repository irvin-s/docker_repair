FROM alpine  
#ENTRYPOINT ["colorpuke.sh"]  
ADD colorpuke.sh /usr/bin/colorpuke.sh  
RUN chmod +x /usr/bin/colorpuke.sh  
CMD ["colorpuke.sh"]  

