# condor - Galaxy  
#  
# VERSION 0.1  
FROM bgruening/galaxy-stable:latest  
  
MAINTAINER Devon P. Ryan, dpryan79@gmail.com  
  
RUN apt-get -qq update && apt-get install --no-install-recommends -y htcondor  
  
ADD configureCondor.py /usr/bin/configureCondor.py  
ADD startCondor.sh /usr/bin/startCondor.sh  
ADD condor.py /galaxy-central/lib/galaxy/jobs/runners/condor.py  
RUN python -m compileall /galaxy-central/lib/galaxy/jobs/runners/condor.py  
RUN chmod +x /usr/bin/configureCondor.py /usr/bin/startCondor.sh  
  
EXPOSE :80  
EXPOSE :21  
EXPOSE :9618  
VOLUME ["/export/","/data/"]  
  
CMD ["/usr/bin/startCondor.sh"]  

