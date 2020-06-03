# Use a base image of Ubuntu 16 and Python 3.6.
FROM genvis/cuda-py36:latest

# Create the App directory.
WORKDIR /app

# Install Requirements.
ADD requirements.txt /app
RUN pip install -r requirements.txt

# Add the command to load VGG16.
ADD cmd_load_vgg.py /app
RUN python cmd_load_vgg.py

# Add dependency for OpenCV.
RUN apt-get install -y libglib2.0-0 libsm6 libxext6 libxrender-dev

# Add the actual application.
ADD app.py /app
ADD logic/* /app/logic/
ADD __init__.py /app

# Run app_server.py when the container launches
CMD ["python", "app.py"]

