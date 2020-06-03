FROM arokem/dipy  
  
ADD dti.py /dti.py  
RUN chmod a+x /dti.py  
  
CMD ["/dti.py"]  
  

