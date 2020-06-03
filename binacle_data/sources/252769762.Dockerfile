FROM jupyter/base-notebook  
MAINTAINER Arnau Siches <asiches@gmail.com>  
  
USER root  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update -yqq \  
&& apt-get install -yqq \  
octave \  
&& apt-get autoclean \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
USER jovyan  
  
#jupyter nbextension enable --py --sys-prefix widgetsnbextension  
RUN pip install octave_kernel \  
&& python -m octave_kernel.install \  
&& conda install -y ipywidgets  

