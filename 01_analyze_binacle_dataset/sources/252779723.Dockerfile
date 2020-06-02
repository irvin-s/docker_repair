FROM ubuntu:16.04  
MAINTAINER Kacper Sokol <ks1591@bristol.ac.uk>  
  
ARG DEBIAN_FRONTEND=noninteractive  
  
USER root  
RUN apt-get update \  
&& apt-get install -y software-properties-common  
RUN apt-add-repository ppa:swi-prolog/devel \  
&& apt-get update \  
&& apt-get install -y \  
git \  
swi-prolog \  
graphviz  
  
# Set environment variables  
ENV SHELL /bin/bash  
ENV ASSIGNMENT_USER jovyan  
ENV ASSIGNMENT_UID 1000  
ENV ASSIGNMENT_DIR /home/$ASSIGNMENT_USER/assignment  
ENV HOME /home/$ASSIGNMENT_USER  
#ENV LC_ALL en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US.UTF-8  
# Create jovyan user with UID=1000 and in the 'users' group \ -N -u $SWISH_UID  
RUN useradd -m -s /bin/bash $ASSIGNMENT_USER \  
&& mkdir -p $ASSIGNMENT_DIR \  
&& chown $ASSIGNMENT_USER $ASSIGNMENT_DIR  
USER $ASSIGNMENT_USER  
  
RUN git clone https://github.com/COMS30106/assignment.git $ASSIGNMENT_DIR \  
&& rm $ASSIGNMENT_DIR/assignment1_12345.pl \  
&& rm $ASSIGNMENT_DIR/assignment2_12345.pl \  
&& rm $ASSIGNMENT_DIR/assignment2_wp_12345.pl  
  
EXPOSE 8000  
WORKDIR $ASSIGNMENT_DIR  
  
ENTRYPOINT ["./ailp.pl"]  

