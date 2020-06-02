FROM haskell:8.0.2  
LABEL maintainer "Brandon Dyck <brandon@dyck.us>"  
  
RUN apt-get update && apt-get install -y rsync openssh-client mercurial  
RUN stack setup --resolver lts-8.21  
RUN stack install --resolver lts-8.21 hakyll

