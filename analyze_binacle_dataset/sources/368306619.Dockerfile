RUN sed 's/main$/main universe/' -i /etc/apt/sources.list  (activar repo universe en Ubuntu)
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN rpm -Uhv http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm

