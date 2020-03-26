FROM debian:jessie  
MAINTAINER blacktop, https://github.com/blacktop  
  
# Install Requirements  
RUN apt-get update -qq  
RUN apt-get install -yq libc6-i386  
  
#Add F-PROT tar.gz  
ADD /fp-Linux.x86.32-ws.tar.gz /fp-Linux.x86.32-ws.tar.gz  
RUN mv /fp-Linux.x86.32-ws.tar.gz/f-prot /opt/f-prot  
#RUN tar xvfz fp-Linux.x86.32-ws.tar.gz  
# Install F-PROT  
RUN ln -fs /opt/f-prot/fpscan /usr/local/bin/fpscan  
#RUN ln -fs /opt/f-prot/doc/man/fpscan.1 /usr/local/man/man1/  
#RUN ln -fs /opt/f-prot/doc/man/fprot-conf.5 /usr/local/man/man5/  
#RUN ln -fs /opt/f-prot/doc/man/fpupdate.8 /usr/local/man/man8/  
RUN ln -fs /opt/f-prot/fpscand /usr/local/sbin/fpscand  
RUN ln -fs /opt/f-prot/fpmon /usr/local/sbin/fpmon  
#RUN ln -fs /opt/f-prot/doc/man/fpscand.8 /usr/local/man/man8/  
#RUN ln -fs /opt/f-prot/doc/man/fp-milter.8 /usr/local/man/man8/  
#RUN ln -fs /opt/f-prot/doc/man/fp-qmail.8 /usr/local/man/man8/  
#RUN ln -fs /opt/f-prot/doc/man/fpmon.8 /usr/local/man/man8/  
#RUN ln -fs /opt/f-prot/doc/man/fp.so.8 /usr/local/man/man8/  
RUN cp /opt/f-prot/f-prot.conf.default /opt/f-prot/f-prot.conf  
RUN ln -fs /opt/f-prot/f-prot.conf /etc/f-prot.conf  
RUN chmod a+x /opt/f-prot/fpscan  
RUN chmod u+x /opt/f-prot/fpupdate  
RUN ln -fs /opt/f-prot/man_pages/scan-mail.pl.8 /usr/share/man/man8/  
#RUN chmod +x /opt/f-prot/mailtools/scan-mail.pl  
# Update F-PROT Definitions  
RUN /opt/f-prot/fpupdate  
  
ADD /malware/EICAR /malware/EICAR  
WORKDIR /malware  
  
ENTRYPOINT ["/usr/local/bin/fpscan"]  
  
CMD ["--help"]  

