FROM comics/centos:latest  
MAINTAINER Ian Merrick <MerrickI@Cardiff.ac.uk>  
  
##############################################################  
# Software: bamtools  
# Software Version: 2.4.0  
# Software Website: https://github.com/pezmaster31/bamtools  
# Description: C++ API & command-line toolkit for working with BAM data  
##############################################################  
  
ENV APP_NAME=bamtools  
ENV VERSION=v2.4.0  
ENV GIT=https://github.com/pezmaster31/bamtools.git  
ENV DEST=/software/applications/$APP_NAME  
ENV PATH=$DEST/$VERSION/bin:$PATH  
ENV LD_LIBRARY_PATH=$DEST/$VERSION/lib/bamtools:$LD_LIBRARY_PATH  
ENV CPATH=$DEST/$VERSION/include/bamtools:$CPATH  
ENV LPATH=$DEST/$VERSION/lib/bamtools:$LPATH  
  
RUN yum install -y \  
cmake \  
zlib-devel ; \  
yum clean all ; \  
git clone $GIT ; \  
cd $APP_NAME ; \  
git checkout tags/$VERSION ; \  
mkdir -p /usr/share/licenses/$APP_NAME-$VERSION ; \  
cp LICENSE /usr/share/licenses/$APP_NAME-$VERSION/ ; \  
mkdir build ; \  
cd build ; \  
cmake -DCMAKE_INSTALL_PREFIX:PATH=$DEST/$VERSION .. ; \  
make ; \  
make install ; \  
cd ../../ ; \  
rm -rf $APP_NAME  
CMD ["/bin/bash"]  
  

