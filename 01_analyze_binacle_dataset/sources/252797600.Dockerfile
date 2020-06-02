FROM java:7  
RUN apt-get -y update && apt-get -y upgrade  
RUN apt-get -y install udev  
RUN apt-get install subversion  
ADD ./rules/65-inilabs.rules /etc/udev/rules.d/65-inilabs.rules  
ADD ./rules/66-inilabs_dev.rules /etc/udev/rules.d/66-inilabs_dev.rules  
RUN svn checkout https://svn.code.sf.net/p/jaer/code  
WORKDIR /code/jAER/trunk/  
CMD ["udevadm control --reload"]  
CMD ["./jAERViewer1.5_linux.sh"]  

