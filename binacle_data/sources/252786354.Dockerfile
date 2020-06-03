FROM dock0/ssh  
MAINTAINER akerl <me@lesaker.org>  
RUN pacman -S --needed --noconfirm make vim-minimal ruby docker-amylum  
RUN chmod u+s /usr/bin/docker  
RUN gem install --no-doc --no-user-install octoauth  
ENV REPO_DIR /var/lib/dock0-manager  
RUN echo $REPO_DIR > /.repo_dir  
ADD bashrc /home/$ADMIN/.bashrc  
ADD load_token /opt/load_token  
ADD repo_dir /service/repo_dir/run  
ADD gitconfig /home/$ADMIN/.gitconfig  

