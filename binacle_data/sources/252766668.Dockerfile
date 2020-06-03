FROM python  
RUN pip install netmiko  
VOLUME /app2/  
CMD [ "python", "./app/ssh_connect.py" ]  

