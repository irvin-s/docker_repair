FROM python:3-onbuild  
MAINTAINER Alex Dowie <adowie01@gmail.com>  
COPY ./areas.py /wms/  
EXPOSE 5000 3306 80  
WORKDIR "/wms"  
CMD ["python","/wms/areas.py"]

