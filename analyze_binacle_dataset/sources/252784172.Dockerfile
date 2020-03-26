# vim:set ft=dockerfile:  
FROM birdhouse/emu:latest  
MAINTAINER Birdhouse <wps@dkrz.de>  
  
LABEL Description="pywps scheduler demo" Vendor="Birdhouse" Version="0.6.0"  
  
# install debian packages with slurm drmaa  
RUN apt-get update && \  
apt-get install -y slurm-drmaa1 slurm-drmaa-dev slurm-llnl  
  
# Install conda packages for scheduler extension  
RUN conda update -y conda && \  
conda install -y -n emu -c birdhouse -c conda-forge psycopg2 drmaa dill  
  
# change demo user home  
RUN usermod -m -d /home/demo www-data && \  
mkdir /home/demo && \  
chown -R www-data /home/demo  
  
# add slurm config  
ADD slurm/slurm.conf /etc/slurm-llnl/slurm.conf  
  
# update emu wps config  
ADD custom.cfg /opt/birdhouse/src/emu/custom.cfg  
  
# copy start script  
COPY start-services.sh /etc/start-services.sh  
  
# Start service ...  
CMD ["/etc/start-services.sh"]  

