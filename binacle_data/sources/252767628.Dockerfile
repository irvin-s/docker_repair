FROM debian:stretch  
MAINTAINER Achim Christ  
  
# Install prerequisites  
ARG DEBIAN_FRONTEND=noninteractive  
RUN apt-get -qq update \  
&& apt-get -qqy install \  
curl \  
gnupg \  
&& curl -sL https://deb.nodesource.com/setup_6.x | bash - \  
&& apt-get -qqy install \  
git \  
g++ \  
gcc \  
graphicsmagick \  
make \  
npm \  
openjdk-8-jre \  
python \  
xsltproc \  
&& npm install -g bower grunt-cli \  
&& rm -rf /var/lib/apt/lists/*  
  
# Create non-root user  
RUN useradd -d /build build \  
&& mkdir /build \  
&& chown build:build /build  
  
# Switch to non-root user  
USER build  
  
# Change to build directory  
WORKDIR /build  
  
# Get the code  
RUN git clone https://github.com/acch/XML-to-bootstrap.git .  
  
# Install build tools  
RUN npm install \  
&& bower install  
  
# Build custom Bootstrap theme  
COPY sass/sample/customvars.scss sass/*.scss /build/sass/  
RUN grunt init  
  
# Populate and expose volumes  
COPY src/ /build/src  
VOLUME ["/build/src", "/build/publish"]  
  
# Expose ports  
EXPOSE 8000  
# Declare Grunt as entrypoint  
ENTRYPOINT ["grunt"]  
CMD ["default"]  

