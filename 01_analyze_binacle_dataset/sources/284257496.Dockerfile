# Licensed to Datalayer (https://datalayer.io) under one or more
# contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership. Datalayer licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

FROM jupyter/scipy-notebook:65761486d5d3

RUN whoami

ARG REPOS_FOLDER=/repos

USER root
RUN mkdir -p $REPOS_FOLDER
RUN chown jovyan:users $REPOS_FOLDER
USER jovyan

WORKDIR $REPOS_FOLDER

RUN git clone --depth 1 https://github.com/datalayer-contrib/jupyterlab

WORKDIR $REPOS_FOLDER/jupyterlab

RUN git checkout datalayer \
    && jlpm install \
    && jlpm build

RUN pip install -e . \
    && jupyter serverextension enable --py jupyterlab --sys-prefix

RUN pip install datascience

RUN jupyter lab build

RUN pip install git+https://github.com/datalayer-contrib/jupyterhub-gitpuller \
    && jupyter serverextension enable --py nbgitpuller --sys-prefix

WORKDIR /home/jovyan

USER root

RUN apt update && apt install -y \
    iputils-ping \
    iproute2 \
    curl \
    telnet

USER $NB_UID

COPY jupyter_notebook_config.py /etc/jupyter/jupyter_notebook_config.py

USER root
RUN mkdir -p $REPOS_FOLDER
RUN chown jovyan:users $REPOS_FOLDER
RUN mkdir -p /home/jovyan/.jupyter/lab/workspaces
RUN chown jovyan:users /home/jovyan/.jupyter
USER jovyan

RUN conda install -y -c conda-forge yarn

RUN cd ~ \
    && git clone --depth 1 https://github.com/datalayer-contrib/data8-materials-fa17 --depth 1

RUN jupyter labextension install @jupyterlab/google-drive --no-build

RUN jupyter labextension install @jupyterlab/xkcd-extension --no-build

RUN cd $REPOS_FOLDER \
    && git clone --depth 1 https://github.com/datalayer-contrib/jupyterlab-git.git --depth 1 \
    && cd jupyterlab-git \
    && git checkout datalayer \
    && pip install -e . \
    && jupyter serverextension enable --py jupyterlab_git --sys-prefix \
    && jupyter labextension link --no-build

RUN cd $REPOS_FOLDER \
    && git clone --depth 1 https://github.com/datalayer-contrib/jupyterlab-github.git --depth 1 \
    && cd jupyterlab-github \
#    && git checkout datalayer \
    && pip install -e . \
    && jupyter serverextension enable --py jupyterlab_github --sys-prefix \
    && jupyter labextension link --no-build

# RUN cd $REPOS_FOLDER \
#     && git clone --depth 1 https://github.com/datalayer-contrib/jupyterlab-github.git --depth 1 \
#     && cd jupyterlab-github \
#     && pip install -e . \
#     && jupyter serverextension enable --py jupyterlab_github --sys-prefix \
#     && jupyter labextension link --no-build

# RUN apt install -y texlive-xetex
RUN cd $REPOS_FOLDER \
    && git clone --depth 1 https://github.com/datalayer-contrib/jupyterlab-latex.git --depth 1 \
    && cd jupyterlab-latex \
    && pip install -e . \
    && jupyter serverextension enable --py jupyterlab_latex --sys-prefix \
    && jupyter labextension link --no-build

#    && sed -e "s|file:/repos|file:/home/jovyan/.repos|g" package.json > package.json.patched \
#    && rm package.json && mv package.json.patched package.json \
RUN cd $REPOS_FOLDER && \
    git clone --depth 1 https://github.com/datalayer/datalayer.git && \
    cd $REPOS_FOLDER/datalayer/apps/library && \
    make install && \
    cd  $REPOS_FOLDER  && \
    git clone  https://github.com/datalayer/notebook.git && \
    cd $REPOS_FOLDER/repos/notebook && \
    make install && \
    make build && \
    make ext-enable

WORKDIR /home/jovyan

RUN jupyter lab build

# COPY drive.jupyterlab-settings $REPOS_FOLDER/jupyter/lab/user-settings/@jupyterlab/google-drive/drive.jupyterlab-settings
COPY drive.jupyterlab-settings /home/jovyan/.jupyter/lab/user-settings/@jupyterlab/google-drive/drive.jupyterlab-settings
