# Use an official Python runtime as a parent image  
FROM python:3.6  
WORKDIR /question_factory  
  
# Copy the current directory contents into the container at /app  
ADD requirements.txt /question_factory  
  
# Install any needed packages specified in requirements.txt  
RUN pip install --trusted-host pypi.python.org -r requirements.txt  
  
RUN apt-get update && apt-get install -y texlive-latex-base dvipng  
  
# Copy the current directory contents into the container at /app  
ADD . /question_factory  
  
# Make port 80 available to the world outside this container  
EXPOSE 80  
# Run app.py when the container launches  
ENTRYPOINT ["python", "question_factory.py"]  
CMD ["--help"]  

