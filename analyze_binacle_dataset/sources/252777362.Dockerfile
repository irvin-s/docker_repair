FROM cggh/biipy_base:v1.1  
MAINTAINER Nicholas Harding <njh@well.ox.ac.uk>  
  
# Install APE via conda  
RUN conda install --yes -c r --name science r-ape=3.3  
  
# python modules via conda  
ENV HDF5_DIR /usr/lib/x86_64-linux-gnu/hdf5/serial  
ADD conda_package_list.txt .  
RUN conda install --yes --name science --file conda_package_list.txt  
RUN conda install --yes --name science -c bpeng simupop=1.1.7  
  
# install bwa, samtools & tabix from bioconda  
RUN conda install --yes --name science bwa=0.7.13  
RUN conda install --yes --name science samtools=1.3.1  
RUN conda install --yes --name science htslib=1.3.1  
  
# Add custom install scripts  
RUN mkdir -p /etc/pki/tls/certs  
RUN cp /etc/ssl/certs/ca-certificates.crt /etc/pki/tls/certs/ca-bundle.crt  
RUN mkdir /biipy  
  
# Install additional python libraries via pip. Versions not on conda.  
# try to do some of these via conda-skeleton/build in future  
ADD pypi_package_list.txt .  
RUN source activate science && \  
pip install --no-cache-dir -r pypi_package_list.txt  
  
ENV DISPLAY :0  
ENV QT_X11_NO_MITSHM 1  
EXPOSE 8888  
ADD ./test.py /biipy/test.py  
RUN source activate science && python3.5 /biipy/test.py  
ADD ./test.ipynb /biipy/test.ipynb  
ADD ./scripts /biipy/scripts  
ADD ./version /biipy/version  
RUN chmod -R 775 /biipy  
CMD /biipy/scripts/notebook.sh  

