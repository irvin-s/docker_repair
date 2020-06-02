FROM amsterdam/panorama_image_processing:python_opencv  
MAINTAINER datapunt.ois@amsterdam.nl  
  
# -- START Build recipe dlib  
RUN apt-get update \  
&& apt-get install -y \  
libboost-python-dev  
  
RUN pip install --no-cache-dir dlib  
# -- END Build recipe dlib  

