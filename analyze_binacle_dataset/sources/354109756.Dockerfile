FROM 0x0l/base:latest

ENV PYTHONIOENCODING UTF-8

RUN apt-get update -qq \
 && apt-get install -yqq \
      curl \
      ffmpeg \
      g++ \
      gcc \
      gfortran \
      git \
      graphviz \
      graphviz-dev \
      less \
      libblosc-dev \
      libedit-dev \
      libfreetype6-dev \
      libgmp-dev \
      libhdf5-dev \
      libjpeg-dev \
      libnetcdf-dev \
      libopenblas-dev \
      libpng3-dev \
      libssl-dev \
      libxml2-dev \
      libxslt-dev \
      libzmq3-dev \
      llvm-3.7-dev \
      pandoc \
      pkg-config \
      python3 \
      python3-dev \
      vim \
      zip

RUN curl https://bootstrap.pypa.io/get-pip.py > get-pip.py \
 && python3 get-pip.py \
 && rm get-pip.py

RUN pip install -q \
      Cython \
      numpy

RUN LLVM_CONFIG=llvm-config-3.7 pip install -q \
      beautifulsoup4 \
      blosc \
      boto \
      bottleneck \
      cppimport \
      cufflinks \
      cvxpy \
      deap \
      gmpy \
      graphviz \
      h5py \
      html5lib \
      ipyparallel \
      jupyter \
      keras \
      llvmlite \
      lxml \
      matplotlib \
      netCDF4 \
      networkx \
      nose \
      numba \
      numexpr \
      nltk \
      pandas \
      pandas-datareader \
      Pillow \
      plotly \
      https://github.com/quantopian/pyfolio/archive/master.zip \
      pygraphviz \
      pykalman \
      https://github.com/pymc-devs/pymc3/archive/master.zip \
      qgrid \
      quandl \
      requests[security] \
      seaborn \
      scikit-image \
      scikit-learn \
      scipy \
      scoop \
      scrapy \
      sqlalchemy \
      statsmodels \
      sympy \
      tables \
      Theano \
      xarray \
      xlrd \
      xlwt \
      https://github.com/quantopian/zipline/archive/master.zip

ENV THEANORC /etc/theanorc:~/.theanorc
COPY theanorc /etc/theanorc

RUN jupyter nbextension enable --py widgetsnbextension
