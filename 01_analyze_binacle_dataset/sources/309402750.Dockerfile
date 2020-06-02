FROM python

# install dependencies 
RUN pip install --upgrade pip && \
    pip install numpy scipy scikit-learn flask-restful 

# add our project
ADD . /

# expose the port for the API
EXPOSE 5000

# run the API 
CMD [ "python", "/api.py" ]

