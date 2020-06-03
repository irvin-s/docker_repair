FROM debian:9

MAINTAINER 0x0L <0x0L@github.com>

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH
ENV QT_QPA_PLATFORM offscreen

RUN apt-get update; apt-get dist-upgrade -y \
 && apt-get install -y \
      ack build-essential bzip2 ca-certificates git graphviz \
      libglib2.0-0 libsm6 libxext6 libxrender1 \
      neovim procps tmux tree unzip wget \
 && apt-get clean; apt-get autoclean

WORKDIR /tmp

RUN wget --quiet https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh \
 && bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda \
 && echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh \
 && conda config --system --set show_channel_urls true \
 && conda config --system --set auto_update_conda false \
 && conda update --all --yes \
 && conda install \
      alembic beautifulsoup4 boto bottleneck cmake cython dask distributed \
      flask hdf4 hdf5 ipyparallel ipywidgets lxml matplotlib networkx nltk \
      nodejs nose notebook numba numexpr numpy pandas patsy pep8 pymc3 pyodbc \
      pytables pytest pywavelets scikit-learn scipy seaborn sqlalchemy sqlite \
      statsmodels sympy theano tqdm uvloop xarray xlrd xlsxwriter xlwt \
 && conda install -c conda-forge ipympl jupyterhub jupyterlab netcdf4 \
 && conda clean -ay; rm Miniconda3-latest-Linux-x86_64.sh

RUN export CVXOPT_BLAS_EXTRA_LINK_ARGS="-L/opt/conda/lib;-Wl,-rpath,/opt/conda/lib,--no-as-needed;-lmkl_rt;-lpthread;-lm;-ldl" \
 && export CVXOPT_BLAS_LIB=mkl_rt \
 && export CVXOPT_LAPACK_LIB=mkl_rt \
 && wget --quiet http://faculty.cse.tamu.edu/davis/SuiteSparse/SuiteSparse-4.5.6.tar.gz \
 && tar -xf SuiteSparse-4.5.6.tar.gz \
 && export CVXOPT_SUITESPARSE_SRC_DIR=/tmp/SuiteSparse \
 && pip install --no-cache-dir cvxopt --no-binary cvxopt \
 && rm -fr /tmp/*

RUN git clone --recursive https://github.com/dmlc/xgboost \
 && cd xgboost; make -j4; make pypack; cd .. \
 && pip install --no-cache-dir ./xgboost/python-package \
 && rm -fr /tmp/*

RUN pip install --no-cache-dir --no-binary :all: lightgbm

RUN pip install --no-cache-dir \
      arch catboost deap GPy gplearn graphviz hmmlearn keras pykalman

RUN sed -i 's/^backend.*//g' /opt/conda/lib/python3.6/site-packages/matplotlib/mpl-data/matplotlibrc

RUN jupyter nbextension enable --system --py widgetsnbextension
# RUN jupyter serverextension enable --system --py ipyparallel \
#  && jupyter nbextension install --system --py ipyparallel \
#  && jupyter nbextension enable --system --py ipyparallel

ADD https://github.com/krallin/tini/releases/download/v0.16.1/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini

ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "/bin/bash" ]

# jupyterlab-hub

# conda install ldap3
# pip install git+https://github.com/jupyterhub/ldapauthenticator
# jupyterhub --generate-config

# c.JupyterHub.authenticator_class = 'ldapauthenticator.LDAPAuthenticator'
#
# c.LDAPAuthenticator.server_address = 'ldap.forumsys.com'
#
# c.LDAPAuthenticator.bind_dn_template = [
#     'uid={username},dc=example,dc=com',
# ]

# spawner

# matplotlib lib inline default backend
# => ipython profile
# => ipython completer

# filterpy
# edward
# ZhuSuan

# conda install protobuf
# pip install tf-nightly

# #https://github.com/tensorflow/tensorflow/issues/12935
# #conda create -n tensorflow python=3.6
# #source activate tensorflow
# pip install --ignore-installed --upgrade \
#   https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-1.4.0-cp36-cp36m-linux_x86_64.whl

# https://stackoverflow.com/questions/40407946/how-to-use-python-requests-to-perform-ntlm-sspi-authentication
