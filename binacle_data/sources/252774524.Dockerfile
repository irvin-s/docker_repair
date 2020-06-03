FROM dock0/ssh  
MAINTAINER akerl <me@lesaker.org>  
RUN pacman -S --needed --noconfirm namcap base-devel ruby vim-minimal  
RUN gem install --no-user-install s3repo  
RUN ln -sfv /usr/bin/pinentry-curses /usr/bin/pinentry  
RUN git clone git://github.com/amylum/repo /home/$ADMIN/repo  
RUN git -C /home/$ADMIN/repo remote set-url origin git@github.com:amylum/repo  
ADD bashrc /home/$ADMIN/.bashrc  
RUN chown -R $ADMIN:$ADMIN /home/$ADMIN  

