FROM ubuntu:latest  
MAINTAINER Christian Lück <christian@lueck.tv>  
  
# add archeologit user account  
RUN useradd -m -d /home/archeologit archeologit  
  
# download latest master of ArcheoloGit  
ADD https://github.com/marmelab/ArcheoloGit/archive/master.zip /master.zip  
  
RUN echo "Install ArcheoloGit" >&2 && \  
\  
echo "[1/7] Install system dependencies" >&2 && \  
DEBIAN_FRONTEND=noninteractive apt-get update && \  
apt-get install -y --no-install-recommends git python3 && \  
apt-get install -y --no-install-recommends unzip npm && \  
\  
echo "[2/7] Unpack zipball" >&2 && \  
unzip /master.zip -d /home/archeologit && \  
mv /home/archeologit/ArcheoloGit-master /home/archeologit/ArcheoloGit && \  
\  
echo "[3/7] Install bower via npm" >&2 && \  
npm install -g bower && \  
\  
echo "[4/7] Install components via bower" >&2 && \  
ln -s /usr/bin/nodejs /usr/bin/node && \  
cd /home/archeologit/ArcheoloGit && \  
HOME=/home/archeologit bower install --allow-root && \  
\  
echo "[5/7] Assign proper access" >&2 && \  
chown -R archeologit:archeologit /home/archeologit/ArcheoloGit && \  
\  
echo "[6/7] Uninstall bower (leave components)" >&2 && \  
npm uninstall -g bower && \  
rm -rf /.npm/ && \  
\  
echo "[7/7] Uninstall system dependencies (leave only git/python)" >&2 && \  
apt-get purge -y unzip npm && \  
apt-get autoremove -y && \  
apt-get clean  
  
# install assets (requires HOME to be set)  
USER archeologit  
  
WORKDIR /home/archeologit/ArcheoloGit  
  
# this is the directory where the source git repository should be mounted to  
VOLUME /data  
  
# expose only http port 8000  
EXPOSE 8000  
# always analyze source volume, then start a lightweight webserver  
CMD ./run.sh /data && python3 -m http.server 8000  

