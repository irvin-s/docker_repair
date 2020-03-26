# Docker file for UMD User Interface  
#  
FROM aaroc/ansiblecontainer:centos6  
MAINTAINER Bruce Becker <bbecker@csir.co.za>  
EXPOSE 8888:8888  
WORKDIR /root  
RUN ["git","clone","https://github.com/AAROC/DevOps"]  
WORKDIR /root/DevOps/Ansible  
RUN ansible-galaxy install -p roles brucellino.Future-Gateway-API-Server  
RUN ansible-playbook -c local -i localhost, FutureGatewayAPIServer.yml  
WORKDIR /root/apiserver  
#ENTRYPOINT ["python","fgapiserver.py"]  

