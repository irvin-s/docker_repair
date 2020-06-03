FROM c3h3/traildb-base:latest

# pyenv image

ENV HOME /root
ENV PYENVPATH $HOME/.pyenv
ENV PATH $PYENVPATH/shims:$PYENVPATH/bin:$PATH

RUN curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash
RUN echo 'eval "$(pyenv init -)"' >  /root/.bashrc


EXPOSE 8888

RUN pyenv update && pyenv install anaconda-2.3.0 && pyenv global anaconda-2.3.0 && ipython profile create

RUN (echo "require(['base/js/namespace'], function (IPython) {" && \
 echo "  IPython._target = '_self';" && \
 echo "});") > /root/.ipython/profile_default/static/custom/custom.js


RUN (echo "c = get_config()" && \
     echo "headers = {'Content-Security-Policy': 'frame-ancestors *'}" && \
     echo "c.NotebookApp.allow_origin = '*'" && \
     echo "c.NotebookApp.allow_credentials = True" && \
     echo "c.NotebookApp.tornado_settings = {'headers': headers}" && \
     echo "c.NotebookApp.ip = '0.0.0.0'" && \
     echo "c.NotebookApp.open_browser = False" && \
     echo "from IPython.lib import passwd" && \
     echo "import os" && \
     echo "c.NotebookApp.password = passwd(os.environ.get('PASSWORD', 'jupyter'))") \
    > /root/.ipython/profile_default/ipython_notebook_config.py


RUN cd /tmp && git clone https://github.com/traildb/traildb-python && cd traildb-python && python setup.py install

RUN mkdir /ipynbs
WORKDIR /ipynbs

CMD ipython notebook --no-browser --ip=0.0.0.0 --port 8888