FROM fedora:latest  
MAINTAINER David July <david.july1991@gmail.com>  
  
USER root  
WORKDIR /root  
  
RUN dnf update -y && dnf install -y \  
@'KDE Plasma Workspaces' \  
@'C Development Tools and Libraries' \  
@'Development Tools' \  
@'Development Libraries' \  
@'Engineering and Scientific' \  
@'Firefox Web Browser' \  
cmake vim tmux texlive tigervnc-server \  
root root-roofit root-spectrum root-python3 \  
opencv opencv-python3 \  
python3-numpy python3-scipy python3-sympy python3-pandas python3-matplotlib \  
&& dnf clean all  
  
RUN ssh-keygen -A  
CMD /sbin/init  
EXPOSE 22 5901  

