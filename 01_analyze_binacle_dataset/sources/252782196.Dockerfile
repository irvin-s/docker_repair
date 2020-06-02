FROM ubuntu:14.04  
MAINTAINER Paolo D. <p.donoriodemeo@cineca.it>  
  
ENV PYVERSION 2  
ENV PYDATAPKG numpy scipy pandas matplotlib seaborn bokeh scikit-learn sympy  
  
##########################  
# APT  
RUN apt-get update && apt-get upgrade -y && \  
apt-get install -y wget curl build-essential python-dev \  
&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
##########################  
# (mini)CONDA package manager  
RUN wget --quiet \  
https://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh && \  
bash Miniconda-latest-Linux-x86_64.sh -b -p /opt/miniconda && \  
rm Miniconda-latest-Linux-x86_64.sh  
ENV PATH /opt/miniconda/bin:$PATH  
RUN chmod -R a+rx /opt/miniconda  
  
##########################  
# Install PyData modules and IPython dependencies  
RUN conda update --quiet --yes conda && \  
conda install --quiet --yes ipython $PYDATAPKG \  
six pip sqlalchemy cython pyzmq statsmodels \  
theano tornado jinja2 sphinx pygments nose readline \  
openpyxl xlrd \  
&& conda clean -y -t  
  
##########################  
# Other python packages  
RUN pip install pip -U && pip install jsonschema  
# Create a basic profile for current user  
RUN ipython profile create  
# Add offline use of mathjax  
RUN python -m IPython.external.mathjax  
# Live slideshows  
WORKDIR /tmp  
RUN wget https://github.com/pdonorio/RISE/archive/master.tar.gz \  
&& tar xvzf *.gz && cd *master && \  
python2 setup.py install \  
&& rm -rf /tmp/*  
  
#####################################  
# Setup and start notebook server  
VOLUME /data  
WORKDIR /data  
CMD ipython notebook --ip=0.0.0.0 --port=8000 --no-browser  

