ARG UBUNTU_VERSION=bionic  
FROM ubuntu:${UBUNTU_VERSION}  
  
# development libraries  
RUN apt-get update  
  
# libgtk-3-0 (gtk runtime) and broadway daemon (libgtk-3-bin)  
RUN apt-get install -y --no-install-recommends libgtk-3-0 libgtk-3-bin glade  
  
# remove package lists and cache to keep image small...  
RUN apt-get clean && apt-get autoclean && rm -rf /var/lib/apt/lists/*  
  
COPY broadway-gtk3-glade.sh /usr/local/bin/broadway-gtk3-glade  
  
EXPOSE 8085  
# overwrite this with 'CMD []' in a dependent Dockerfile  
CMD ["/usr/local/bin/broadway-gtk3-glade"]  

