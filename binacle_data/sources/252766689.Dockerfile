FROM ubuntu:16.04  
LABEL maintainer="akshmakov@gmail.com"  
  
# cvsclone compilation  
WORKDIR /tmp/  
  
#Copy this strange flex file - sigh  
COPY external/cvsclone.l /tmp/  
  
# Install Base Required Packages  
# Currently this image builds the cvsclone tool  
# but eventually will move to a seperate build script  
# cvsclone is not maintained but fully functional in a  
# static environment like docker  
# we make use of it for convenience  
RUN apt-get update &&\  
apt-get install -y \  
cvs \  
cvs2svn \  
git \  
ruby \  
gcc \  
flex \  
cowsay &&\  
rm -rf /var/lib/apt/lists/* &&\  
flex cvsclone.l &&\  
gcc -Wall -O2 lex.yy.c -o cvsclone &&\  
mv cvsclone /usr/local/bin/cvsclone &&\  
apt-get purge -y gcc flex &&\  
apt-get autoremove -y &&\  
rm -rf /var/lib/apt/lists/* &&\  
rm /tmp/*  
  
#set up environment  
WORKDIR /workdir/  
  
ENV HOME=/workdir/  
  
VOLUME /workdir/  
  
COPY cvs2git-migrator.sh /usr/local/bin/cvs2git-migrator  
  
COPY cvs2git-migrator-default.options /etc/cvs2git-migrator/cvs2git.options  
  
COPY external/git-move-refs.py /usr/local/bin/git-move-refs.py  
  
RUN mkdir -p /workdir/.cvs2git-migrator/cache &&\  
chmod +x /usr/local/bin/*  
  
ENTRYPOINT [ "cvs2git-migrator" ]  
  
CMD ["-h"]

