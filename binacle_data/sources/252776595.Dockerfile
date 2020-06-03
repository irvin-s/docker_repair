FROM mongo:3.4.0  
ADD /change_password_entrypoint.sh /change_password_entrypoint.sh  
ENTRYPOINT ["/change_password_entrypoint.sh"]  
CMD mongod --auth  

