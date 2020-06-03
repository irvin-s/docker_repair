FROM python:3.5-onbuild  
RUN python setup.py develop  
CMD btcal  

