# DO NOT EDIT FILES CALLED 'Dockerfile'; they are automatically  
# generated. Edit 'Dockerfile.in' and generate the 'Dockerfile'  
# with the 'rake' command.  
# The suggested name for this image is: bioconductor/devel_proteomics.  
FROM bioconductor/devel_protmetcore2  
  
MAINTAINER lg390@cam.ac.uk  
  
ADD install.R /tmp/  
  
# invalidates cache every 24 hours  
ADD http://master.bioconductor.org/todays-date /tmp/  
  
RUN R -f /tmp/install.R  

