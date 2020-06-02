FROM node:5  
MAINTAINER aahoo <github.com/aahoo>  
ENV NODE_ENV development  
# defining a user because yeoman doesn't like root user!  
ENV USER yeoman  
RUN apt-get update  
RUN apt-get -y install sudo  
# to skip password prompt for sudo users  
RUN echo %sudo ALL=NOPASSWD: ALL >> /etc/sudoers  
# setting up a user  
RUN useradd --create-home --shell /bin/bash $USER && adduser $USER sudo  
ENV HOME /home/$USER  
WORKDIR $HOME  
# making the $USER owner of node_modules dir to avoid permission errors  
RUN chown -R $USER /usr/local/lib/node_modules/  
RUN npm install -g gulp-cli bower grunt-cli  
# switching to the non-root user  
USER $USER  
RUN sudo npm install -g yo  
RUN npm cache clear  
CMD ["/bin/bash"]  

