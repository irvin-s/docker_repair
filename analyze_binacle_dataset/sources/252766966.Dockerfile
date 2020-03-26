FROM albfan/jhbuild:debian  
LABEL maintainer "albertofanjul@gmail.com"  
  
RUN $HOME/.local/bin/jhbuild build gnome-todo  

