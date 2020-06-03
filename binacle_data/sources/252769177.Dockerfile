#Dockerfile for angelcam/cve-public  
# start from basic engine image  
FROM angelcam/cve-image:latest  
  
MAINTAINER Martin Dobrovolny "martin@angelcam.com"  
ADD . /root/tmp/cvelib/  
  
RUN cd /root/tmp/cvelib \  
&& LD_LIBRARY_PATH=./lib make check HARDWARE=generic+sse3 \  
&& make installdirs-dev install-dev HARDWARE=generic+sse3 DESTDIR= \  
&& rm -r /root/tmp/* \  
&& ldconfig  
  
#clean after yourself  
RUN rm -r /root/tmp  
  
#create user cvapp  
RUN useradd -m cvapp  
  
#copy internal script for engine run  
COPY script/automation/runengineinternal.sh /home/cvapp/runengineinternal.sh  
  
#set rights for script  
RUN chmod a+x /home/cvapp/runengineinternal.sh  
  
#set entry point  
CMD /home/cvapp/runengineinternal.sh  
  

