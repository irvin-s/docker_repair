FROM fnproject/python:3.7-dev

WORKDIR /function

# Install libraries needed by python dependencies
RUN apt-get update && \
    apt-get install --no-install-recommends -qy \
    build-essential \
    gcc \
    cmake \
    libgnutls28-dev \
    libcurl4-gnutls-dev \
    git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ADD requirements.txt .

RUN pip3 install --target /python/ --no-cache --no-cache-dir \
                 -r requirements.txt && \
    rm -fr ~/.cache/pip /tmp* requirements.txt func.yaml Dockerfile .venv

# Configure environment
ENV SHELL=/bin/bash \
    FN_USER=fnuser \
    FN_UID=1000 \
    FN_GID=100

ENV HOME=/function

ADD fix-permissions /usr/bin/fix-permissions

# Create fn user with UID=1000 and in the 'users' group
# and make sure these dirs are writable by the `users` group.
RUN useradd -m -s /bin/bash -N -u $FN_UID $FN_USER && \
    fix-permissions $HOME

WORKDIR /function

RUN mkdir /extralibs

ENV PYTHONPATH=/python \
    LD_LIBRARY_PATH=/extralibs:$LD_LIBRARY_PATH

# Add the function last as this is the thing that will change
# most often
ENV PYTHON_EXT=/function/python_modules

USER $FN_USER

RUN git clone https://github.com/chryswoods/acquire

USER root

WORKDIR acquire
RUN pip3 install --upgrade --force-reinstall -r requirements.txt
RUN pip3 install --upgrade --force-reinstall -r server-requirements.txt
RUN pip3 install --upgrade --force-reinstall pytest requests

USER $FN_USER
RUN PYTHONPATH=.:services pytest test/pytest/

ENTRYPOINT ["bash"]

# Become the $FN_USER so that nothing runs as root
USER $FN_USER
