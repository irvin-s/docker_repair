FROM fedora:latest  
  
RUN dnf -y upgrade  
RUN dnf -y install python python-virtualenv supervisor tar postgresql \  
which libsmi mongodb hg quilt  
RUN dnf -y install postgresql-devel gcc make automake gcc-c++ gmp-devel  
  
WORKDIR /opt  
RUN hg clone https://bitbucket.org/nocproject/noc  
  
# upgrade pip  
RUN pip install pip --upgrade  
  
# setup virtual environment  
RUN virtualenv /opt/noc  
  
# install basic requirements for convinience  
RUN . /opt/noc/bin/activate \  
&& pip install \  
-r /opt/noc/etc/requirements/common.txt \  
-r /opt/noc/etc/requirements/noc.txt \  
\--trusted-host cdn.nocproject.org \  
\--find-links https://cdn.nocproject.org/pkg/simple/ \  
\--allow-all-external  
  
# cleanup  
RUN dnf -y clean all  
RUN rm -rf /tmp/*  
  
# setup user and group  
RUN groupadd noc  
RUN useradd -g noc -s /bin/sh -d /home/noc -n noc  
  
# fix permissions and setup directories  
RUN chown -R noc:noc /opt/noc  
RUN mkdir -p /var/noc/{repo,backup,log}  
  
# add configuration files  
ADD ./assets/upgrade.defaults /opt/noc/etc/upgrade.defaults  
  
# configure web defaults  
RUN sed -i s/'127.0.0.1'/'0.0.0.0'/g /opt/noc/etc/noc-web.defaults  
  
VOLUME ["/var/noc/repo", "/var/noc/backup", "/var/noc/log", "/opt/noc"]  
  
EXPOSE 8000  
ENTRYPOINT ["/opt/noc/noc"]  

