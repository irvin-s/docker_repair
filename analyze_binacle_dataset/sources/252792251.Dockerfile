FROM chbrandt/root:latest  
  
MAINTAINER "Carlos H Brandt <carloshenriquebrandt at gmail>"  
ENV PROFRC /etc/profile.d/thisdocker.sh  
  
RUN grep --quiet "$PROFRC" /etc/bashrc || \  
echo "source $PROFRC" >> /etc/bashrc  
  
ENV INSTALLDIR /usr/local  
  
RUN PKG="Miniconda-latest-Linux-x86_64.sh" && \  
curl https://repo.continuum.io/miniconda/$PKG \  
-o /tmp/miniconda.sh && \  
chmod +x /tmp/miniconda.sh && \  
/tmp/miniconda.sh -b -p $INSTALLDIR/anaconda && \  
rm -f /tmp/miniconda.sh && \  
echo "export PATH=$INSTALLDIR/anaconda/bin:\$PATH" >> $PROFRC  
  
RUN echo "export ANNZSYS=$INSTALLDIR/annz" >> $PROFRC && \  
source $PROFRC && \  
conda install -y astropy && \  
git clone https://github.com/chbrandt/ANNZ $ANNZSYS && \  
PYPATH=$ANNZSYS/lib:$PYTHONPATH && \  
eval $(echo "export PYTHONPATH=$PYPATH" | tee -a $PROFRC) && \  
python -c 'from annz.helperFuncs import *; init()'  
  
RUN git clone https://github.com/chbrandt/docker_commons.git && \  
ln -sf docker_commons/entrypoint.sh /.  
  
ENV EXECAPP python  
  
ENTRYPOINT ["/entrypoint.sh"]  
#CMD ["--help"]  

