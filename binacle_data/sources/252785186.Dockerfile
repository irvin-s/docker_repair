ARG tag="latest"  
FROM cognexa/archlinux:"${tag}"  
MAINTAINER Cognexa Solutions s.r.o. <docker@cognexa.com>  
  
# install additional packages  
RUN pacman --noconfirm --needed -S \  
python-babel \  
python-click \  
python-matplotlib \  
python-numpy \  
python-pyaml \  
python-requests \  
python-ruamel-yaml \  
python-testfixtures \  
&& paccache -rfk0  
  
RUN sudo -u aur trizen --noconfirm --needed -S \  
python-typing \  
python-tabulate \  
&& paccache -rfk0 \  
&& trizen -Scc --noconfirm  
  
# install cxflow  
RUN pip install --no-cache-dir git+https://github.com/Cognexa/cxflow.git \  
&& pip install --no-cache-dir git+https://github.com/Cognexa/cxflow-scikit.git  

