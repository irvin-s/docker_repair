FROM python:2.7-slim

MAINTAINER "Toshiki Inami <t-inami@arukas.io>"

# Set the applilcation directory
WORKDIR /app

# Get pip to download and install requirements:
COPY requirements.txt /app
RUN pip install -r requirements.txt

# Copy our code from the current folder to /app inside the container
COPY . /app

# Make port 5000 available for publish
EXPOSE 80

# Start server
CMD python /app/server.py
