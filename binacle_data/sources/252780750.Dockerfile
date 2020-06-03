FROM python:3.5  
# AFL direcotry  
ENV AFL_DIR /srv/afl  
# Repository directory  
ENV REPO_DIR /srv/lop_farm  
# Django app directory  
ENV APP_DIR $REPO_DIR/app  
# virtual environment directory  
ENV VENV_DIR /srv/venv  
# virtual environment pip path  
ENV PIP $VENV_DIR/bin/pip  
# virtual environment Python path  
ENV PYTHON $VENV_DIR/bin/python  
# filename of afl file to download and extract  
ENV AFL_FILENAME afl-1.95b.tgz  
# Python requirements filename  
ENV REQUIREMENTS requirements.txt  
  
RUN apt-get update && apt-get install -y \  
gcc \  
libffi-dev \  
make \  
libssl-dev \  
wget  
  
# Install AFL  
ENV AFL_HARDEN 1  
WORKDIR $AFL_DIR  
RUN wget http://lcamtuf.coredump.cx/afl/releases/$AFL_FILENAME  
RUN tar --strip-components=1 -xf $AFL_FILENAME  
RUN make  
RUN make install  
  
RUN python3 -m venv $VENV_DIR  
ENV PATH $PATH:$VENV_DIR/bin/  
  
RUN $PIP install cython  
  
WORKDIR $REPO_DIR  
  
COPY $REQUIREMENTS $REQUIREMENTS  
RUN $PIP install -r $REQUIREMENTS  
  
COPY . $REPO_DIR  
  
EXPOSE 8000  
ENTRYPOINT ["/srv/lop_farm/etc/docker-run.sh"]  

