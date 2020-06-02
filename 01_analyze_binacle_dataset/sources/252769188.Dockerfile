FROM jenkins:latest  
MAINTAINER Angelo E. Valdez <angeloe.valdez@gmail.com>  
  
#Deshacerse la configuración de contraseña de administrador  
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"  
COPY plugins-v2.txt /usr/share/jenkins/ref/plugins-v2.txt  
  
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins-v2.txt  
  

