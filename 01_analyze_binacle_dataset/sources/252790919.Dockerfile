# Start with an existing Jupyter image with some Python libs preinstalled  
FROM cuongdd1/tensorflow  
  
# Add the scotch notebook  
COPY service.py /notebooks/  
COPY static /notebooks/static/  
  
VOLUME /notebooks  
  
# Rest API  
EXPOSE 5000  
# Tell the kernel gateway to load the scotch notebook by default  
CMD ["python", "/notebooks/service.py"]

