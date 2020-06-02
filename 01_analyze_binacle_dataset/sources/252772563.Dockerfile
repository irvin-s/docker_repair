FROM debian:stretch-slim  
  
MAINTAINER Benjah1 <benjaminhuang1@gmail.com>  
  
ARG GIT_NAME="benjah1"  
ARG GIT_EMAIL="benjaminhuang1@gmail.com"  
ENV GIT_AUTHOR_NAME=$GIT_NAME  
ENV GIT_AUTHOR_EMAIL=$GIT_EMAIL  
ENV GIT_COMMITTER_NAME=$GIT_NAME  
ENV GIT_COMMITTER_EMAIL=$GIT_EMAIL  
  
ENV TERM=xterm-256color  
ENV DISABLE=""  
ENV VIM=/var/lib/vim  
  
ADD ./ /vimrc  
RUN cd /vimrc/scripts && sh build.sh  
  
WORKDIR /src  
CMD ["tail", "-f", "/dev/null"]  

