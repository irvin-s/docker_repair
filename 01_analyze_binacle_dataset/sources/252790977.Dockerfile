FROM fedora  
  
RUN dnf -y update &&\  
dnf -y install make\  
gcc\  
findutils\  
bc\  
openssl-devel\  
elfutils-libelf-devel\  
hostname\  
ncurses-devel\  
openssl\  
perl &&\  
dnf clean all  
  

