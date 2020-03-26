###########################################################################
# Dugong - Scientific Linux Containers for Bioinformatics
# ========================================================
#
# Current development is led by Fabiano Menegidio.
#
# Bioinformatician/Bioinformaticist at the Laboratory of Functional 
# and Structural Genomics of the Integrated Nucleus of Biotechnology 
# at the University of Mogi das Cruzes, Brazil.
# 
# Contact: fabiano.menegidio@biology.bio.br
# GitHub: https://github.com/fabianomenegidio
#
#
###########################################################################

FROM ubuntu:wily
MAINTAINER Fabiano Menegidio <fabiano.menegidio@biology.bio.br>

############### Metadata
ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="e.g. https://github.com/fabianomenegidio/dugong-bioinformatics/tree/master/DugongGUI/XFCE"

LABEL base.image="ubuntu:latest" \
      version="2017040" \
      name="DugongGUI" \
      flavour="Xfce4" \
      base="Ubuntu latest" \
      description="Scientific Linux Container" \
      website="https://fabianomenegidio.github.io/dugong-bioinformatics/" \
      repository="https://github.com/fabianomenegidio/dugong-bioinformatics" \
      license="MIT" \
      tags="Bioinformatics"

############### Environment config
ENV DEBIAN_FRONTEND noninteractive
ENV HOME /headless
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $HOME/install
ENV NB_USER dugong
ENV NB_UID 1000
ENV CONDA_DIR $HOME/.conda2/

ADD .config/scripts $STARTUPDIR
ADD .config/scripts/.bashrc $HOME/.bashrc
ADD .config/scripts/.bash_profile $HOME/.bash_profile
ADD .config/install/ $INST_SCRIPTS/
ADD tty.js /tty.js/

COPY config/start.sh /usr/local/bin/
COPY config/start-notebook.sh /usr/local/bin/
COPY config/start-singleuser.sh /usr/local/bin/
COPY config/jupyter_notebook_config.py $HOME/.jupyter/

WORKDIR $HOME

############### Add dependencies and update packages
RUN apt-key adv --recv-key --keyserver keyserver.ubuntu.com "A6616109451BBBF2" \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9 \
    && echo "deb http://packages.linuxmint.com sarah main upstream import backport" >> /etc/apt/sources.list.d/mint.list \
    && echo 'deb http://nebc.nerc.ac.uk/bio-linux/ unstable bio-linux' >> /etc/apt/sources.list.d/biolinux.list \
    && echo 'deb http://ppa.launchpad.net/nebc/bio-linux/ubuntu precise main' >> /etc/apt/sources.list.d/biolinux.list \
    && echo 'deb-src http://ppa.launchpad.net/nebc/bio-linux/ubuntu precise main' >> /etc/apt/sources.list.d/biolinux.list \
    && echo 'deb http://cran.r-project.org/bin/linux/ubuntu precise/' >> /etc/apt/sources.list.d/biolinux.list \
    && apt-get update \
    && apt-get install -y --allow-unauthenticated --force-yes bio-linux-keyring \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && apt-get update && apt-get install -y --allow-unauthenticated make grep sed sudo dpkg git wget zip \
    build-essential python python-dev bzip2 locales ca-certificates vim gdebi-core bash-completion apt-utils \
    openjdk-7-jre openssh-server unzip curl net-tools icedtea-7-plugin zlib1g-dev libqt4-dbus libqt4-network nodejs \
    ruby-dev rubygems ruby screen mlocate nano asciinema python-pip python-numpy \
    && wget --quiet https://github.com/krallin/tini/releases/download/v0.10.0/tini \
    && echo "1361527f39190a7338a0b434bd8c88ff7233ce7b9a4876f3315c22fce7eca1b0 *tini" | sha256sum -c - \
    && mv tini /usr/local/bin/tini && chmod +x /usr/local/bin/tini \
    && wget https://mega.nz/linux/MEGAsync/xUbuntu_16.04/amd64/megacmd-xUbuntu_16.04_amd64.deb \
    && gdebi -n megacmd-xUbuntu_16.04_amd64.deb \
    && apt-get -f install && rm megacmd-xUbuntu_16.04_amd64.deb \
    && apt-get autoremove -y && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && locale-gen en_US.UTF-8 \
    && git clone https://github.com/Linuxbrew/linuxbrew.git ~/.linuxbrew \
    && bash -c "$(curl -L https://basemount.basespace.illumina.com/install)" \
    && gem install showterm \
    && wget --quiet https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh \
    && /bin/bash Miniconda2-latest-Linux-x86_64.sh -b -p ~/.conda2 \
    && rm Miniconda2-latest-Linux-x86_64.sh \
    && ~/.conda2/bin/conda config --add channels defaults \
    && ~/.conda2/bin/conda config --add channels conda-forge \
    && ~/.conda2/bin/conda config --add channels r \
    && ~/.conda2/bin/conda config --add channels bioconda \
    && ~/.conda2/bin/conda update --all \
    && ~/.conda2/bin/conda clean -tipsy \
    && chmod +X /dockerstartup/*.sh && chmod 755 /dockerstartup/*.sh \
    && /dockerstartup/generate_container_user.sh \
    && chmod +x /usr/local/bin/start.sh \
    && chmod +x /usr/local/bin/start-notebook.sh \
    && chmod +x /usr/local/bin/start-singleuser.sh \
    && /bin/bash /headless/install/set_user_permission.sh /dockerstartup /headless
    
USER dugong

RUN ~/.conda2/bin/conda update --all \
    && ~/.conda2/bin/conda install jupyter ipython nb_conda \
    && ~/.conda2/bin/conda clean -tipsy
    
USER root

############### http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8
ENV LANG C.UTF-8

VOLUME ["$HOME/data"]

ENTRYPOINT ["tini", "--"]
ENTRYPOINT ["/dockerstartup/startup.sh"]

EXPOSE 22
EXPOSE 3000
EXPOSE 8888

RUN chmod 777 /var/tmp && chown -R root:root /var/tmp && chmod 777 /tmp && chown -R root:root /tmp \
    && chown -R $USER:$USER $HOME/data

WORKDIR $HOME/data
