FROM cboettig/labnotebook  
  
## These refer to specific paths on Savio that for some reason singularity  
## needs to match exactly when OverlayFS is not available. Not clear  
## why singularity cannot map volumes to use different paths inside  
## container to the paths they have outside the container, this clearly  
## is very bad for portability.  
  
  
RUN mkdir -p /global/home/users/cboettig && mkdir -p /global/scratch  
  

