FROM python:2.7-alpine3.6  
ENV PYENV_ROOT /opt/pyenv  
ENV PATH "$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"  
ENV CONCHOID_DOCKER_PYENV_HOME /conchoid/docker-pyenv  
  
COPY . $CONCHOID_DOCKER_PYENV_HOME  
  
RUN set -x \  
&& $CONCHOID_DOCKER_PYENV_HOME/install-builddeps.sh \  
&& $CONCHOID_DOCKER_PYENV_HOME/install-pyenv.sh \  
&& rm -r $PYENV_ROOT/.git  

