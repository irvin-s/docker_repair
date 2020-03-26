# Basic docker image for Monocle
# Usage:
#   docker build -t Monocle
#   docker run -d --name Monocle -P Monocle

FROM python:3.6

# Default port the webserver runs on
EXPOSE 5000

# Working directory for the application
WORKDIR /usr/src/app

# Set Entrypoint with hard-coded options
ENTRYPOINT ["python3"]
CMD ["./scan.py"] 

# Install required system packages
RUN apt-get update && apt-get install -y --no-install-recommends libgeos-dev

COPY requirements.txt /usr/src/app/
COPY optional-requirements.txt /usr/src/app/

RUN pip3 install --no-cache-dir -r requirements.txt
RUN pip3 install --no-cache-dir -r optional-requirements.txt

# Copy everything to the working directory (Python files, templates, config) in one go.
COPY . /usr/src/app/
