
###########################################
## Hadoop 2.6 and Jupyter

FROM sequenceiq/hadoop-ubuntu:2.6.0
MAINTAINER "Paolo D'Onorio De Meo <p.donoriodemeo@gmail.com>"

# Let hadoop be in the path
ENV PATH $HADOOP_PREFIX/bin:$PATH

###########################################
# Install all OS dependencies for fully functional notebook server
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -yq --no-install-recommends \
    git vim wget build-essential python-dev bzip2 unzip libsm6 \
    libxml2-dev libxslt1-dev \
    #ca-certificates \
    #pandoc texlive-latex-base texlive-latex-extra texlive-fonts-extra texlive-fonts-recommended \
    #supervisor sudo \
    && apt-get clean

###########################################
# Install conda
ENV CONDA_DIR /opt/conda
RUN echo 'export PATH=$CONDA_DIR/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet \
    https://repo.continuum.io/miniconda/Miniconda3-3.9.1-Linux-x86_64.sh && \
    /bin/bash /Miniconda3-3.9.1-Linux-x86_64.sh -b -p $CONDA_DIR && \
    rm Miniconda3-3.9.1-Linux-x86_64.sh && \
    $CONDA_DIR/bin/conda install --yes conda==3.14.1
ENV PATH $CONDA_DIR/bin:$PATH

###########################################
# Install Python 3 packages
RUN conda install --yes \
    numpy scipy pandas matplotlib seaborn scikit-learn bokeh \
    && conda clean -yt

# Install Jupyter notebook
RUN conda install --yes \
    ipython-notebook terminado \
    && conda clean -yt

# Configure Jupyter
RUN ipython profile create

###########################################
# install some other pip libs
RUN pip install plumbum howdoi

###############################
# Add mrjob from Yelp
WORKDIR /opt
# Install and not remove from installation!
RUN git clone https://github.com/Yelp/mrjob \
    && cd mrjob && pip install -e .

###############################
# Add offline use of mathjax
RUN python -m IPython.external.mathjax

###############################
# Live slideshows
RUN mkdir -p /root/.jupyter/nbconfig && \
    wget https://github.com/pdonorio/RISE/archive/master.tar.gz \
    && tar xvzf *.gz && cd *master && \
    python setup.py install

###############################
# Last fixes

# languages and UTF-8
RUN apt-get update && apt-get install -y language-pack-en
ENV LANG en_US.UTF-8
RUN locale-gen en_US.UTF-8
RUN dpkg-reconfigure locales

# startup script
ENV HADOOP_HOME $HADOOP_PREFIX
ENV STARTUPSCRIPT /bootme.sh
RUN echo "#!/bin/bash" > $STARTUPSCRIPT && \
    echo "/etc/bootstrap.sh &\njupyter notebook --no-browser --ip=0.0.0.0\n" \
    >> $STARTUPSCRIPT && \
    chmod +x $STARTUPSCRIPT

# Other usefull variables
ENV TERM xterm
#ENV HADOOP_VERSION `hadoop version | grep Hadoop | awk '{print $2}'`
ENV HADOOP_VERSION 2.6.0
ENV HADOOP_JARS $HADOOP_PREFIX/share/hadoop/tools/lib
ENV HADOOP_EXAMPLES $HADOOP_PREFIX/share/hadoop/mapreduce/hadoop-mapreduce-examples-${HADOOP_VERSION}.jar
ENV HADOOP_STREAMING $HADOOP_JARS/hadoop-streaming-${HADOOP_VERSION}.jar

CMD [ "/bootme.sh" ]

# A data directory
WORKDIR /data
