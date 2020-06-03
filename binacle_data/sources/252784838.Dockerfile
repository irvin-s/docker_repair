FROM codekoala/arch  
MAINTAINER Josh VanderLinden <codekoala@gmail.com>  
  
RUN pacman -Syu --needed --noconfirm \  
python-sphinx \  
python-sphinx_rtd_theme \  
sphinxcontrib-programoutput \  
make && \  
rm -rf /var/cache/pacman  
  
CMD ["make", "html"]  
  
# vim:ft=Dockerfile:  

