FROM debian:latest

# Install necessary linux packages from apt-get
RUN apt-get update --fix-missing && apt-get install -y eatmydata

RUN eatmydata apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git \
    libfreetype6-dev \
    swig \
    mpich \
    pkg-config \
    gcc \
    wget \
    curl \
    vim \
    nano \
    libgl1-mesa-glx \
    ffmpeg \
    fonts-liberation

# Install anaconda
RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/archive/Anaconda3-5.2.0-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh

# Setup anaconda path
ENV PATH /opt/conda/bin:$PATH

# Create compatibility Python 2.7 environment
RUN conda create -n py27 python=2.7
RUN ["/bin/bash", "-c", "source activate py27 && \
    conda install -y numpy \
    scipy \
    pandas \
    scikit-learn \
    ipython \
    matplotlib \
    jupyter \
    seaborn && python -m ipykernel install"]

# Install packages needed
RUN conda install -c brainiak -c defaults -c conda-forge brainiak
RUN pip install git+https://github.com/ljchang/neurolearn && pip install git+https://github.com/eackermann/hmmlearn.git && pip install pymvpa2  \
    nilearn \
    hypertools \
    mne \
    deepdish \
    nelpy \
    dask \
    pynv \
    seaborn \
    supereeg && python -m ipykernel install

# Clean up
RUN conda clean --all -y && apt-get autoremove

# Create some command aliases and turn off jupyter notebook tokens
RUN echo 'alias jp="jupyter notebook --port=9999 --no-browser --ip=0.0.0.0 --allow-root"' >> /root/.bashrc
RUN echo 'alias jl="jupyter lab --port=9999 --no-browser --ip=0.0.0.0 --allow-root"' >> /root/.bashrc
RUN mkdir -p /root/.jupyter && echo "c.NotebookApp.token = u''" >> /root/.jupyter/jupyter_notebook_config.py && echo "c.NotebookApp.notebook_dir = '/mnt'" >> /root/.jupyter/jupyter_notebook_config.py

# What should we run when the container is launched
ENTRYPOINT ["/bin/bash"]
