FROM python:3.6.2  
MAINTAINER Me <because.it.needs.atleast.1.arg>  
  
VOLUME /config  
VOLUME /code  
  
ENV TERM=xterm  
ENV PYMSSQL_BUILD_WITH_BUNDLED_FREETDS=1  
# Install from pip  
RUN pip3 install --no-cache-dir sanic pymssql  
  
CMD [ "python", "/code/main.py" ]  

