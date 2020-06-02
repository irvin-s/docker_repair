FROM ubuntu:xenial  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update  
RUN apt-get upgrade -q -y  
RUN apt-get dist-upgrade -q -y  
  
RUN apt-get install -y apt-utils  
RUN apt-get install -y sudo  
RUN apt-get install -y figlet  
RUN apt-get install -y strace  
RUN apt-get install -y curl  
RUN apt-get install -y wget  
RUN apt-get install -y man  
RUN apt-get install -y git  
RUN apt-get install -y zsh  
RUN apt-get install -y vim  
RUN apt-get install -y htop  
RUN apt-get install -y xclip  
RUN apt-get install -y php7.0-cli  
RUN apt-get install -y php7.0-xml  
RUN apt-get install -y php7.0-soap  
RUN apt-get install -y php7.0-curl  
RUN apt-get install -y php-pear  
RUN apt-get install -y pear-channels  
  
# Install tmux to gain split screen management and screen sharing capabilities  
RUN apt-get install -y tmux  
  
# Create an instructive welcome message  
RUN echo 'figlet Baywa CLI' >> /root/.bashrc  
RUN echo 'echo "\n\  
*** GET STARTED ***\n\  
tmux is used to maintain concurrent windows.\n\  
Note you can create a new window using ctrl-b c, and you can\n\  
navigate to an existing window using ctrl-b <window>.\n\  
exit the session using ctrl-b d.\n\  
split the screen vertically using ctrl-b %.\n\  
for more commands use ctrl-b ?. \n\  
\n\  
TO START THE CLI...\n\  
$ ./baywa-cli.php # run the baywa-cli\n\  
\n\  
"' >> /root/.bashrc  
  
ADD . /src  
  
# Start user in the source code directory...  
WORKDIR /src  
  
# Clean up APT when done.  
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
ENTRYPOINT tmux new  
  

