FROM gitlab/gitlab-runner:latest  
MAINTAINER CodeX Systems <webmaster@codex.systems>  
COPY assets/ /  
  
# Add additional packages  
RUN apt-get --quiet update \  
&& apt-get --yes --quiet install \  
lxc  
  
# Image cleanup  
RUN apt-get clean \  
&& rm -rf \  
/tmp/* \  
/var/tmp/* \  
/var/lib/apt/lists/*  
  
# Start Runner  
ENTRYPOINT ["/usr/local/bin/runner"]

