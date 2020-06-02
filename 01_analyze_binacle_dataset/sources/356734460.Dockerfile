# Python3 notebook & pydata stack via continuum conda

# Stack with no hub:
# $ cd python/py3base; docker build -t pdonorio/py3kbase .
# $ cd ../py3dataconda; docker build -t pdonorio/py3dataconda .

# Run notebook with /opt/start

FROM pdonorio/py3kbase
MAINTAINER "Paolo D'Onorio De Meo <p.donoriodemeo@gmail.com>"

###############################
## A little Docker magic here

# Force bash always
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
# Default miniconda installation
ENV CONDA_ENV_PATH /opt/miniconda
ENV MY_CONDA_PY3ENV "python34"
# This is how you will activate this conda environment
ENV CONDA_ACTIVATE "source $CONDA_ENV_PATH/bin/activate $MY_CONDA_PY3ENV"

###############################
# (mini)CONDA package manager

# Download and create
RUN wget --quiet \
    https://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh && \
    bash Miniconda-latest-Linux-x86_64.sh -b -p $CONDA_ENV_PATH && \
    rm Miniconda-latest-Linux-x86_64.sh && \
    chmod -R a+rx $CONDA_ENV_PATH
ENV PATH $CONDA_ENV_PATH/bin:$PATH

###############################
# Extra libs
RUN apt-get install -y \
# Needed by matplotlib inline
    python-qt4 \
# Needed by howdoi
    libxml2-dev libxslt-dev

###############################
# Install PyData modules and IPython dependencies
WORKDIR /tmp

# Switch to python 3.5 very soon
RUN conda create -y -n $MY_CONDA_PY3ENV python=3.4
RUN conda update --quiet --yes conda

RUN conda install -y -n $MY_CONDA_PY3ENV \
        pip jupyter ipython notebook ipywidgets \
        six sqlalchemy cython pyzmq statsmodels \
        theano tornado jinja2 sphinx pygments nose readline openpyxl xlrd
RUN conda install -y -n $MY_CONDA_PY3ENV \
        numpy scipy pandas scikit-learn sympy \
        matplotlib seaborn bokeh
RUN conda clean -y -t

###############################
# Add other libraries not found in anaconda
RUN $CONDA_ACTIVATE && pip install howdoi
# Note: this is how you use the conda pip instead of the existing one

###############################
# Script: Activate virtualenv and launch notebook
ENV STARTSCRIPT /opt/start
#RUN source activate $MY_CONDA_PY3ENV
RUN echo "#!/bin/bash" > $STARTSCRIPT
RUN echo "$CONDA_ACTIVATE" >> $STARTSCRIPT
RUN echo -e "# install kernels\npython3 -m ipykernel.kernelspec" >> $STARTSCRIPT
RUN echo -e "# launch notebook\njupyter notebook --ip=0.0.0.0 --no-browser" >> $STARTSCRIPT
RUN chmod +x $STARTSCRIPT

WORKDIR /data
