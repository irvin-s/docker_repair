# Use an official distro of the Ubuntu container
FROM ubuntu

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
ADD . /app

# Install any needed packages specified in requirements.txt
# RUN pip install -r requirements.txt

RUN apt-get update
RUN apt-get -y install apache2

# Make port 80 available to the world outside this container
EXPOSE 80

# Define environment variable
ENV NAME World

# Run app.py when the container launches
# CMD ["python", "app.py"]

# RUN service mysql restart && /tmp/setup.sh
RUN service apache2 restart && /app/setup.sh
