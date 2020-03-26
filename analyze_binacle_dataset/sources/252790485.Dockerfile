###############################################  
# Robot Framework Hub Container  
#  
# Additional resources will be available at  
# https://github.com/carfi/rfhub  
#  
# DISCLAIMER:  
# I am not associated to Robot Framework Hub project.  
# More information about RF Hub available at  
# https://github.com/boakley/robotframework-hub  
###############################################  
FROM python:2.7  
  
MAINTAINER Davide Carfi <davide@carfi.org>  
  
RUN pip install --upgrade pip  
RUN pip install robotframework-hub  
  
EXPOSE 7070  
  
VOLUME /keywords  
  
CMD python -m rfhub -i 0.0.0.0 /keywords &

