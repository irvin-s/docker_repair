FROM datascienceschool/ubuntu:latest
MAINTAINER "Joel Kim" admin@datascienceschool.net

ARG USER_ID=dockeruser
ENV USER_ID $USER_ID

############################################################################
# R
################################################################################
USER root
RUN \
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 && \
add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/' && \
apt update -y -q && \
echo

# R and RStudio-server
ENV RSTUDIOSERVER_VERSION 1.2.1335
RUN \
apt install -y -q r-base r-base-dev && \
mkdir -p /download && cd /download && \
wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-${RSTUDIOSERVER_VERSION}-amd64.deb && \
gdebi --n rstudio-server-${RSTUDIOSERVER_VERSION}-amd64.deb && \
rm -rf /download

# Settings for RStudio-Server
EXPOSE 8787

# enable R package install
RUN chmod a+w /usr/local/lib/R/site-library

################################################################################
# Node.js
################################################################################

USER root
RUN \
curl -sL https://deb.nodesource.com/setup_10.x -o nodesource_setup.sh && \
/bin/bash nodesource_setup.sh && \
DEBIAN_FRONTEND=noninteractive apt install -y -q nodejs && \
rm -rf nodesource_setup.sh && \
npm install -g npm@latest && \
npm install -g ijavascript --unsafe-perm=true --allow-root && \
echo ""

################################################################################
# Python
################################################################################

# Anaconda config
ENV ANACONDA_PATH /home/$USER_ID/anaconda3
ENV ANACONDA_INSTALLER Anaconda3-2019.03-Linux-x86_64.sh

# add path to root account
ENV PATH $ANACONDA_PATH/bin:$PATH

# Change user to $USER_ID
USER $USER_ID
WORKDIR /home/$USER_ID
ENV HOME /home/$USER_ID
ENV PATH $ANACONDA_PATH/bin:$PATH
RUN \
echo "export PATH=$PATH:$ANACONDA_PATH/bin" | tee -a /home/$USER_ID/.bashrc

# Anaconda install
RUN \
mkdir -p /home/$USER_ID/download && cd /home/$USER_ID/download && \
wget https://repo.anaconda.com/archive/$ANACONDA_INSTALLER -nv -q && \
/bin/bash ~/download/$ANACONDA_INSTALLER -b && \
conda update --yes conda && \
conda update --yes anaconda && \
conda update --yes --all && \
conda clean --yes --all && \
rm -rf /home/$USER_ID/download

################################################################################
# OpenCV
################################################################################

USER root
ENV CV_VERSION 4.1.0
RUN \
cd /home/$USER_ID && \
wget https://github.com/opencv/opencv/archive/${CV_VERSION}.zip -O opencv.zip && \
wget https://github.com/opencv/opencv_contrib/archive/${CV_VERSION}.zip -O opencv_contrib.zip && \
unzip opencv.zip && \
unzip opencv_contrib.zip && \
mv opencv-${CV_VERSION} opencv && \
mv opencv_contrib-${CV_VERSION} opencv_contrib && \
cd /home/$USER_ID/opencv && \
mkdir build && \
cd build && \
cmake \
    -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D INSTALL_C_EXAMPLES=OFF \
    -D OPENCV_ENABLE_NONFREE=ON \
    -D OPENCV_EXTRA_MODULES_PATH=/home/$USER_ID/opencv_contrib/modules \
    -D PYTHON_EXECUTABLE=$ANACONDA_PATH/bin/python \
    -D PYTHON3_EXECUTABLE=$ANACONDA_PATH/bin/python \
    -D PYTHON_INCLUDE_DIR=$ANACONDA_PATH/include/python3.7m \
    -D PYTHON_LIBRARY=$ANACONDA_PATH/lib/libpython3.7m.so \
    -D OPENCV_PYTHON3_INSTALL_PATH=$ANACONDA_PATH/lib/python3.7/site-packages \
    -D BUILD_EXAMPLES=OFF \
    -D BUILD_TESTS=OFF \
    .. && \
make && make install && ldconfig && \
cd /home/$USER_ID && \
rm -rf opencv.zip opencv_contrib.zip opencv opencv_contrib && \
echo

################################################################################
# Python Packages
################################################################################

ARG CACHEBUST=1
COPY pkgs_conda.txt        /home/$USER_ID/download/pkgs_conda.txt
COPY pkgs_conda-forge.txt  /home/$USER_ID/download/pkgs_conda-forge.txt
COPY pkgs_pip.txt          /home/$USER_ID/download/pkgs_pip.txt
COPY install_pkg.sh        /home/$USER_ID/download/install_pkg.sh

# fix ownership
USER root
RUN \
mkdir -p /home/$USER_ID/.config && \
mkdir -p /home/$USER_ID/.config/git && \
chown -R $USER_ID:$USER_ID /home/$USER_ID/.config

USER $USER_ID
RUN \
cd /home/$USER_ID/download && \
source ./install_pkg.sh

# tensorboard port
EXPOSE 6006

################################################################################
# Jupyter Notebook Settings
################################################################################

EXPOSE 8888

RUN ipython profile create
COPY ipython_config.py /home/$USER_ID/.ipython/profile_default/ipython_config.py
COPY ipython_kernel_config.py /home/$USER_ID/.ipython/profile_default/ipython_kernel_config.py
COPY 00.py /home/$USER_ID/.ipython/profile_default/startup/00.py

RUN jupyter notebook --generate-config
USER root
RUN \
chown -R $USER_ID:$USER_ID /home/$USER_ID/.jupyter && \
chmod -R 755 /home/$USER_ID/.jupyter

USER $USER_ID
RUN \
echo "c.NotebookApp.notebook_dir = u\"/home/$USER_ID\"" | tee -a /home/$USER_ID/.jupyter/jupyter_notebook_config.py && \
echo "c.NotebookApp.token = u\"\"" | tee -a /home/$USER_ID/.jupyter/jupyter_notebook_config.py && \
echo "c.NotebookApp.password = u\"\"" | tee -a /home/$USER_ID/.jupyter/jupyter_notebook_config.py && \
echo "c.NotebookApp.iopub_data_rate_limit = 10000000" | tee -a /home/$USER_ID/.jupyter/jupyter_notebook_config.py

# install ipython magics
RUN pip install git+git://github.com/joelkim/ipython-tikzmagic.git

# Node.js kernel
RUN ijsinstall

# R kernel
USER root
RUN \
echo 'install.packages(c(\"repr\",\"IRdisplay\",\"pbdZMQ\",\"devtools\"),repos=c(\"http://cran.rstudio.com\"))' | xargs R --vanilla --slave -e && \
echo 'devtools::install_github(paste0(\"IRkernel/\",c(\"repr\",\"IRdisplay\",\"IRkernel\")))' | xargs R --vanilla --slave -e && \
echo 'IRkernel::installspec(displayname=\"R\",user=FALSE)' | xargs R --vanilla --slave -e && \
echo

################################################################################
# Set TLS certifates
################################################################################

USER root
RUN mkdir -p /etc/pki/tls/certs/ && \
cp /etc/ssl/certs/ca-certificates.crt /etc/pki/tls/certs/ca-bundle.crt

################################################################################
# Postgresql Settings
################################################################################

USER root
ADD "./.postgres_db_setup.sql" "/home/$USER_ID/"

EXPOSE 5432

################################################################################
# Supervisor Settings
################################################################################

USER root
COPY supervisord.conf /etc/supervisor/supervisord.conf
RUN \
sed -i "s/USER_ID/$USER_ID/g" /etc/supervisor/supervisord.conf  && \
mkdir -p /var/log/supervisor  && \
chown $USER_ID:$USER_ID /var/log/supervisor

################################################################################
# Data
################################################################################

USER $USER_ID
RUN \
mkdir -p /home/$USER_ID/data && cd /home/$USER_ID/data && \
echo

################################################################################
# Postprocessing
################################################################################

ADD "./.docker-entrypoint.sh" "/home/$USER_ID/"

# fix ownership
USER root

RUN \
chown syslog:syslog /etc/rsyslog.conf && \
chown $USER_ID:$USER_ID /home/$USER_ID/.*  && \
chown $USER_ID:$USER_ID /home/$USER_ID/*  && \
chown -R $USER_ID:$USER_ID /home/$USER_ID/.ipython  && \
chown -R $USER_ID:$USER_ID /home/$USER_ID/.jupyter  && \
chown -R $USER_ID:$USER_ID /home/$USER_ID/.local && \
chown -R $USER_ID:$USER_ID /home/$USER_ID/.npm && \
echo ""

# Jupyter notebook extension setting
USER $USER_ID
RUN \
jupyter contrib nbextension install --user && \
jupyter nbextensions_configurator enable --user && \
jupyter nbextension enable --py widgetsnbextension && \
jupyter nbextension install --user --py ipyparallel  && \
jupyter nbextension enable --user --py ipyparallel && \
jupyter serverextension enable --user --py ipyparallel && \
ipcluster nbextension enable --user && \
jupyter serverextension enable ipyparallel.nbextension

################################################################################
# Fixing
################################################################################

# ImageMagick security fix
USER root
COPY policy.xml /etc/ImageMagick-6/policy.xml

# statsmodels incompatibility with scipy 1.3.0
USER $USER_ID
RUN \
pip install -U git+https://github.com/statsmodels/statsmodels

################################################################################
# Tini
################################################################################

# Tini operates as a process subreaper for jupyter. This prevents kernel crashes.
USER root
ADD https://github.com/krallin/tini/releases/download/v0.18.0/tini /usr/bin/tini
RUN chmod a+x /usr/bin/tini

ENTRYPOINT ["/usr/bin/tini", "--", "/bin/bash", ".docker-entrypoint.sh"]
