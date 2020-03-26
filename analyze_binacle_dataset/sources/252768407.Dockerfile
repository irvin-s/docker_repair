# Indicate what base image we want to build on top of  
FROM python:3.4.6  
# Install the extra python libraries we'll be using  
RUN pip install nibabel scikit-image  
  
# Copy our algorithm script into the image  
COPY bone_segmentation.py /bone_segmentation.py  
  
# Make our script the executable that will be run via "docker run"  
ENTRYPOINT ["python", "/bone_segmentation.py"]

