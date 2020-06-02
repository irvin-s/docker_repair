FROM ubuntu:16.10

COPY install /tmp/install
RUN chmod u+x /tmp/install 
RUN /tmp/install --update=true
RUN /tmp/install --package=git --package=vim --package=tree --package=libpython2.7
RUN /tmp/install --source=apt --apt=vapor
RUN /tmp/install --source=apt --swift=4.0.2 
RUN /tmp/install --clean=true

ENV PATH /usr/bin:$PATH

# Set work dir to /projects
WORKDIR /projects

# Launch the image with this command: 
# docker run -ti --rm --privileged=true -v $(pwd)/swift4/projects:/projects --name swift4 swift4
