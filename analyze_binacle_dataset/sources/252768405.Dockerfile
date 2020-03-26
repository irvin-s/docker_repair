# Indicate what base image we want to build on top of  
FROM zachmullen/resonant_course:latest  
  
# Install the extra python libraries we'll be using  
RUN pip install nibabel scikit-image  
  
# Copy our algorithm script into the image  
COPY compare_images.py /compare_images.py  
  
# Make our script the executable that will be run via "docker run"  
ENTRYPOINT ["python", "/compare_images.py"]  

