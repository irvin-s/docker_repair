FROM centos:6.6  
MAINTAINER Daniel Silva <dap1995@gmail.com>  
  
RUN yum -y install xinetd cvs  
ADD cvspserver /etc/xinetd.d/cvspserver  
RUN useradd cvs -M -p '$1$O.xY9ih7$W9j8v0/qP0VxygLItVxt.1'  
RUN mkdir -p /Cvs/Projetos  
RUN cvs -d /Cvs/Projetos init  
RUN chown root:cvs -R /Cvs/Projetos  
RUN chmod g+srwx /Cvs/Projetos  
  
EXPOSE 2401  
CMD xinetd -stayalive -dontfork  

