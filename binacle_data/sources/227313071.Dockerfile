FROM swift4

COPY install /tmp/install
RUN chmod u+x /tmp/install 
RUN /tmp/install --update=true
RUN /tmp/install --package=wget
RUN /tmp/install --source=apt --apt=vapor
RUN /tmp/install --package=ssh --package=ctls --package=vapor
RUN /tmp/install --clean=true

# Set work dir to /vapor
WORKDIR /vapor

EXPOSE 8080

# Launch the image with this command: 
# docker run -ti --rm --privileged=true --name vapor -p 127.0.0.1:8080:8080 -v $(pwd)/vapor/projects:/vapor vapor
