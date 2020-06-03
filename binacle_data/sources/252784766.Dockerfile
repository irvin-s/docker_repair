FROM opensuse:42.2  
RUN zypper --non-interactive in bind-utils \  
&& zypper clean  
  
CMD ["/bin/bash"]  

