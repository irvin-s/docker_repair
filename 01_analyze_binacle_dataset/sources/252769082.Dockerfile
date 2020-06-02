FROM metricsgrimoire/sortinghat  
  
RUN pip install Flask flask-restful  
  
ADD . /apihat  
  
WORKDIR /apihat  
  
EXPOSE 5000  
ENTRYPOINT ["./apihat/app.py"]

