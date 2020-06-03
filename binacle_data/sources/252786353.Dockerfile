FROM dock0/env  
MAINTAINER akerl <me@lesaker.org>  
RUN pacman -S --noconfirm --needed weechat tmux python2  
ADD firstrun /home/$ADMIN/.firstrun/irc  
RUN chown -R $ADMIN:$ADMIN /home/$ADMIN  
RUN echo 'all' >> /var/lib/ssh/classes  

