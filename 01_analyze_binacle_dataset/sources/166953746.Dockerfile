#
# million12/typo3-flow-neos-abstract
#
FROM million12/nginx-php:latest
MAINTAINER Marcin Ryzycki marcin@m12.io

RUN \
  `# Install Beard - https://github.com/mneuhaus/Beard` \
  curl -s http://beard.famelo.com/ > /usr/bin/beard && chmod +x /usr/bin/beard && \
  beard --version

# Add all files from container-files/ to the root of the container's filesystem
ADD container-files /

# Run this in you image if you want to pre-install your Flow/Neos site
#RUN . /build-typo3-app/pre-install-typo3-app.sh
