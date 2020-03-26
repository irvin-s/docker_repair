from clojure:lein-2.6.1  
ARG USERNAME=clojure  
ARG USERID=64535  
ARG GROUPID=$USERID  
  
RUN addgroup -gid $GROUPID $USERNAME && \  
adduser --disabled-password --gecos '' -u $USERID \--gid $GROUPID $USERNAME  
  
RUN mkdir -p /home/$USERNAME/project  
WORKDIR /home/$USERNAME/project  
USER $USERNAME  
ENV HOME /home/$USERNAME  
  

