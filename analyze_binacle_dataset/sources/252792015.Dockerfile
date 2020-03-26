# Indicate what base image we want to build on top of  
FROM python:3.5  
# Install the extra python libraries we'll be using  
RUN pip install nibabel scikit-image pycontextnlp  
  
# Copy our algorithm script into the image  
COPY ct_segmenter.py /ct_segmenter.py  
  
# Make our script the executable that will be run via "docker run"  
ENTRYPOINT ["python", "/ct_segmenter.py"]  

