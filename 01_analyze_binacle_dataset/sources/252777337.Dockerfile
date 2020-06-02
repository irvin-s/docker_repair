FROM cgal/testsuite-docker:archlinux  
MAINTAINER Philipp Moeller <bootsarehax@gmail.com>  
  
RUN pacman -Syy && pacman -S --noconfirm \  
bison \  
flex \  
git \  
graphviz \  
python2 \  
python2-pyquery \  
texlive-bin \  
&& \  
pacman -Scc --noconfirm  
  
USER makepkg  
WORKDIR /tmp/makepkg  
RUN git clone https://github.com/CGAL/doxygen.git && \  
cd doxygen && ./configure && \  
make  
USER root  
RUN cd /tmp/makepkg/doxygen && make install  
  
COPY ./docker_entrypoint.sh /  
ENTRYPOINT ["/docker_entrypoint.sh"]  
CMD ["cgal_build_documentation"]  

