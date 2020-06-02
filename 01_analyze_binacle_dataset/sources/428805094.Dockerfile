# Use an official Python runtime as a parent image
FROM python:3.7.2

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Run Cmake
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y cmake
RUN apt-get install -y python3-pip

# Install any needed packages specified in requirements.txt
RUN pip3 install -U instabotai

# Make port 80 available to the world outside this container
EXPOSE 800

# Run app.py when the container launches
ENTRYPOINT ["python3", "instabotai/app.py"]
