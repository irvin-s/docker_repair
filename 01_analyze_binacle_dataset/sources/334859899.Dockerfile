# Use an official Python runtime as a parent image
FROM python:3.6

# Set the working directory to /app
WORKDIR .

# Install any needed packages specified in requirements.txt
RUN pip install --trusted-host pypi.python.org -r requirements.txt

# Make port available to the world outside this container
EXPOSE 4050

# Define environment variable
ENV NAME python_gekko

# Run app.py when the container launches
CMD ["python", "macd.py"]