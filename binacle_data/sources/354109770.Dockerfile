FROM 0x0l/jupyter:latest

# Numpy / Scipy
RUN apt-get update -qq \
 && apt-get install -yqq gfortran libopenblas-dev

RUN pip3 install -q numpy scipy

# More packages
RUN apt-get install -yqq \
      graphviz \
      hdf5-tools \
      libav-tools \
      libfreetype6-dev \
      libgraphviz-dev \
      libhdf5-dev \
      liblzo2-dev \
      libpng-dev \
      libxml2-dev \
      libxslt-dev \
      libzip2 \
 && apt-get clean -yqq \
 && rm -rf /var/lib/apt/lists/*

RUN pip3 install -q \
      beautifulsoup4 \
      blosc \
      bokeh \
      bottleneck \
      cython \
      h5py \
      lxml \
      matplotlib \
      networkx \
      nltk \
      numexpr \
      pandas \
      pandas-datareader \
      patsy \
      pillow \
      pygraphviz \
      pykalman \
      pyyaml \
      quandl \
      scikit-learn \
      seaborn \
      sqlalchemy \
      statsmodels \
      sympy \
      textblob \
      toolz \
      xlrd \
      xlsxwriter \
 && rm -fr /root/.cache /tmp/*

RUN pip3 install https://github.com/0x0L/PyTables/archive/develop.zip

RUN pip3 install -q \
      https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.7.1-cp34-none-linux_x86_64.whl \
      https://github.com/Theano/Theano/archive/master.zip \
      https://github.com/fchollet/keras/archive/master.zip \
      https://github.com/lasagne/lasagne/archive/master.zip \
      https://github.com/pymc-devs/pymc3/archive/master.zip \
 && rm -fr /root/.cache /tmp/*
