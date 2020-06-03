FROM chbrandt/heasoft:6.15  
MAINTAINER "Carlos Brandt <carloshenriquebrandt at gmail>"  
ENV PROFRC /etc/profile.d/thisdocker.sh  
  
RUN grep --quiet "$PROFRC" /etc/bashrc || \  
echo "source $PROFRC" >> /etc/bashrc  
  
RUN INSTALLDIR="/usr/local" && \  
PKG="Miniconda3-latest-Linux-x86_64.sh" && \  
curl https://repo.continuum.io/miniconda/$PKG \  
-o /tmp/miniconda.sh && \  
chmod +x /tmp/miniconda.sh && \  
/tmp/miniconda.sh -b -p $INSTALLDIR/anaconda && \  
rm -f /tmp/miniconda.sh && \  
CONDABIN="$INSTALLDIR/anaconda/bin" && \  
echo "export PATH=$CONDABIN:\$PATH" >> $PROFRC && \  
$CONDABIN/conda install -y pandas=0.20.3 astropy=2.0.2  
  
RUN yum -y install perl-CPAN && yum clean all && \  
PERL_MM_USE_DEFAULT=1 && \  
cpan App::cpanminus && \  
cpanm WWW::Mechanize && \  
cpanm Carp::Assert && \  
cpanm Archive::Tar  
  
RUN git clone https://github.com/CBDC/swift_deepsky.git && \  
cd /swift_deepsky && ./install.sh  
  
ENV EXECAPP /swift_deepsky/bin/pipeline.sh  

