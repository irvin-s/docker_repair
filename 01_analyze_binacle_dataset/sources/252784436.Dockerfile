FROM python:2.7.11  
RUN apt-get update && apt-get install -y \  
wget curl git vim tig tree cmake  
  
ENV PROJECT_VERSION=0.0.4  
WORKDIR /opt/  
RUN git clone \--depth=1 -b maint/v0.24 https://github.com/libgit2/libgit2.git  
  
RUN mkdir /opt/libgit2/build  
WORKDIR /opt/libgit2/build  
  
RUN cmake .. -DCMAKE_INSTALL_PREFIX=../_install -DBUILD_CLAR=OFF  
RUN cmake --build . --target install  
  
ENV LIBGIT2=/opt/libgit2/_install/ LD_LIBRARY_PATH=/opt/libgit2/_install/lib  
  
RUN mkdir /opt/bitwrap /repo  
  
COPY requirements.txt /opt/bitwrap/  
RUN pip install -r /opt/bitwrap/requirements.txt  
  
COPY gitwrap_io /opt/bitwrap/gitwrap_io  
COPY entry.sh /opt/bitwrap/  
COPY service.tac /opt/bitwrap/  
  
WORKDIR /opt/bitwrap  
  
EXPOSE 80  
VOLUME ["/repo"]  
  
ENV BITWRAP_REPO_PATH=/repo/  
ENV BITWRAP_PORT=80  
ENTRYPOINT ["/opt/bitwrap/entry.sh"]  

