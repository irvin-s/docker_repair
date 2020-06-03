FROM arokem/dipy  
  
ADD sfm.py /sfm.py  
RUN chmod a+x /sfm.py  
  
CMD ["/sfm.py"]  

