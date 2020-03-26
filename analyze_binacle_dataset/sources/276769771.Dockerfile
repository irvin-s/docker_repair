# jupyter project recommends pinning the base image: https://github.com/jupyter/docker-stacks#other-tips-and-known-issues
# jupyter project recently removed support for python2, we'll recreate it using their commit as a guide
# https://github.com/jupyter/docker-stacks/commit/32b3d2bec23bc46fab1ed324f04a0ad7a7c73747#commitcomment-24129620
FROM jupyter/minimal-notebook:f9e77e3ddd6f

ENV CLOJURE_VERSION 1.10.0.442

# install conda-build into the root environment. useful for reproducing travis runs.
# also install java-jdk for clojure notebooks
RUN conda install --quiet --yes -c bioconda conda-build java-jdk

# Install Python 2 packages
COPY files/conda_python2.txt /tmp/
RUN conda create --quiet --yes -p $CONDA_DIR/envs/python2 python=2.7 \
    --file /tmp/conda_python2.txt
# Add shortcuts to distinguish pip for python2 and python3 envs
RUN ln -s $CONDA_DIR/envs/python2/bin/pip $CONDA_DIR/bin/pip2 && \
    ln -s $CONDA_DIR/bin/pip $CONDA_DIR/bin/pip3

# Import matplotlib the first time to build the font cache.
ENV XDG_CACHE_HOME /home/$NB_USER/.cache/
ENV MPLBACKEND=Agg
RUN $CONDA_DIR/envs/python2/bin/python -c "import matplotlib.pyplot"

USER root

# install packages that are nice for dev environment.
RUN apt-get -qy update && apt-get install -qy curl htop less rsync && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# install clojure and lein
RUN curl -fsSL -o /tmp/linux-install.sh https://download.clojure.org/install/linux-install-${CLOJURE_VERSION}.sh && \
    curl -fsSL -o /usr/local/bin/lein https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein && \
    chmod +x /usr/local/bin/lein && \
    bash /tmp/linux-install.sh

# Install Python 2 kernel spec globally to avoid permission problems when NB_UID
# switching at runtime and to allow the notebook server running out of the root
# environment to find it. Also, activate the python2 environment upon kernel
# launch.
RUN pip install kernda --no-cache && \
    $CONDA_DIR/envs/python2/bin/python -m ipykernel install && \
    kernda -o -y /usr/local/share/jupyter/kernels/python2/kernel.json && \
    pip uninstall kernda -y

# add custom css/logo and tutorials (use a skeleton directory in case a bind mount is used)
COPY files/skel/dot_jupyter/ /usr/local/etc/skel/jupyter/.jupyter/
COPY tutorials/ /usr/local/etc/skel/jupyter/tutorials
RUN rsync -aq /home/$NB_USER/.cache /usr/local/etc/skel/jupyter/
RUN chown -R $NB_USER /usr/local/etc/skel/jupyter

USER $NB_USER

# install clojupyter
RUN git clone https://github.com/roryk/clojupyter /tmp/clojupyter && \
    cd /tmp/clojupyter && \
    make && make install

# bash improvements for developer environment
RUN git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it && \
    bash ~/.bash_it/install.sh --silent && \
    echo "source activate python2\nalias pytest=py.test\nexport SCM_CHECK=false" >> /home/$NB_USER/.bashrc

# install the probcomp libraries, fix permissions
COPY files/conda_probcomp.txt /tmp/
RUN conda install -n python2 --quiet --yes -c probcomp -c cidermole -c fritzo -c ursusest \
    --file /tmp/conda_probcomp.txt && \
    conda remove -n python2 --quiet --yes --force qt pyqt && \
    conda clean -tipsy && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# Add local files as late as possible to avoid cache busting
COPY files/docker-entrypoint.sh /usr/local/bin/

# Make installing pip packages in child images more intuitive
ENV PATH $CONDA_DIR/envs/python2/bin:$PATH

ENTRYPOINT      ["tini", "--", "docker-entrypoint.sh"]
CMD             ["start-notebook.sh"]
