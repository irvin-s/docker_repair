FROM ubuntu:16.04

ARG py_version

# Validate that arguments are specified
RUN test $py_version || exit 1

# Install python and other scikit-learn runtime dependencies
# Dependency list from http://scikit-learn.org/stable/developers/advanced_installation.html#installing-build-dependencies
RUN apt-get update && \
    apt-get -y install build-essential libatlas-dev git wget curl nginx jq && \
    if [ $py_version -eq 2 ]; \
       then apt-get -y install python-dev python-setuptools \
                     python-numpy python-scipy libatlas3-base; \
       else apt-get -y install python3-dev python3-setuptools \
                     python3-numpy python3-scipy libatlas3-base; fi

# Install pip
RUN cd /tmp && \
     curl -O https://bootstrap.pypa.io/get-pip.py && \
     if [ $py_version -eq 2 ]; \
        then python2 get-pip.py; \
        else python3 get-pip.py; fi && \
     rm get-pip.py

# Python won’t try to write .pyc or .pyo files on the import of source modules
# Force stdin, stdout and stderr to be totally unbuffered. Good for logging
ENV PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1 PYTHONIOENCODING=UTF-8 LANG=C.UTF-8 LC_ALL=C.UTF-8

# Install dependencies from pip
# Install Scikit-Learn; 0.20.0 supports both python 2.7+ and 3.4+
RUN pip install --no-cache -I scikit-learn==0.20.0 retrying
