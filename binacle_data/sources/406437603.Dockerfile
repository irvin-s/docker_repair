FROM tensorflow/tensorflow:2.0.0a0

# copy the adjusted system bashrc
COPY bashrc /etc/bash.bashrc

# default jupyter notebook port
ENV NB_PORT 8888

# workdir
WORKDIR /tutorial

# minimal software stack
RUN apt-get update
RUN apt-get install -y wget nano less htop git

# python software
RUN pip install --upgrade pip
RUN pip install --upgrade ipython jupyter
RUN pip install --upgrade scinum wget matplotlib scikit-learn pandas tables
RUN pip install --upgrade --no-deps git+https://github.com/riga/LBN.git
RUN pip install --upgrade jupyter_contrib_nbextensions RISE

# create a custom home directory
RUN mkdir -p /home/user && chmod a+rwX /home/user

# jupyter extensions
RUN jupyter contrib nbextension install --sys-prefix
RUN jupyter nbextension install rise --py --sys-prefix

# load the 3pia/iml2019 repo
RUN git clone https://github.com/3pia/iml2019.git /tutorial && chmod a+rwX /tutorial

# default command (run_tutorial is defined in bashrc)
CMD bash -i -l -c run_tutorial
