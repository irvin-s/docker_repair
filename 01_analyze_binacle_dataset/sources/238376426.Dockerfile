FROM asgard/python-ml:latest

# DL snap repo
RUN git clone https://github.com/snap-stanford/snap

# install snap
RUN cd snap && make all


