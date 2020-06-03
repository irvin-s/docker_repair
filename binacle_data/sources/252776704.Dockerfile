FROM ubuntu:14.04  
RUN apt-get update  
RUN apt-get install -y build-essential  
ADD c/ /c/  
RUN gcc -o /mcsend /c/mcsend.c ; gcc -o /mcreceive /c/mcreceive.c  
ADD run.sh /run.sh  
RUN chmod +x /run.sh  
CMD ["/run.sh"]

