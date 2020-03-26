# Use an official Python runtime as a parent image  
FROM python:2.7-slim  
  
# Set the working directory to /app  
WORKDIR /app  
  
COPY static/* static/  
COPY templates/* templates/  
COPY requirements.txt requirements.txt  
COPY init.py init.py  
COPY util.py util.py  
COPY optiMeet.py optiMeet.py  
COPY database.py database.py  
COPY google_places_api_key.txt google_places_api_key.txt  
RUN mkdir db  
  
# Install any needed packages specified in requirements.txt  
RUN pip install -r requirements.txt  
  
# decide whether or not to debug optimeet  
ENV OPTIMEET_DEBUG False  
ENV PORT 80  
EXPOSE 80  
RUN python init.py  
  
# Run app.py when the container launches  
CMD ["python", "optiMeet.py"]  

