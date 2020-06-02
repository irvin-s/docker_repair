FROM lukin0110/docker-vtk-python  
RUN pip install pandas  
RUN ldconfig && mkdir -p /N/home /N/u /N/dc2 /N/soft  

