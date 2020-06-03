FROM jupyter/jupyterhub:latest  
MAINTAINER a504082002 <a504082002@gmail.com>  
  
RUN mkdir /build && cd /build  
ADD configs/openblas.conf /etc/ld.so.conf.d/openblas.conf  
ADD configs/* /build/  
  
# build openblas (clone from ogrisel/openblas)  
RUN bash /build/build_openblas.sh  
  
# build numpy, scipy and sklearn (clone from ogrisel/sklearn-openblas)  
RUN bash /build/build_sklearn.sh  
  
# build dependencies  
RUN apt-get update -qq &&\  
apt-get install -yq libfreetype6 libfreetype6-dev\  
libpng12-0 libpng12-dev\  
libpq-dev python3-dev\  
g++  
  
RUN pip3 install -r /build/requirements.txt  
  
ENTRYPOINT ["tini", "--"]  
CMD ["jupyter", "notebook"]  

