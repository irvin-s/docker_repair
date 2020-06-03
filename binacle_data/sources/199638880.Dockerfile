# This dockerfile is made for creating binders at mybinder.org
FROM andrewosh/binder-python-3.5-mini

MAINTAINER Joshua Milas <josh.milas@gmail.com>

USER root

# Add context
ADD . .

# Install IArm
# TODO replace with `pip install iarm`
# Installing via `pip` won't get the latest developmental version
RUN python setup.py install && \
    python setup.py clean --all && \
    rm -rf dist iarm.egg-info

# Install the IArm kernel
RUN python -m iarm_kernel.install

USER main
