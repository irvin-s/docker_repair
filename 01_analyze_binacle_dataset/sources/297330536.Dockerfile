FROM python:3.6-alpine
MAINTAINER Antonis Kalipetis <akalipetis@gmail.com>

# Install dependencies and create working directory
RUN pip install flask gunicorn && mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Set the command to run the correct Flask app
ENV FLASK_APP=app.py
CMD ["flask", "run", "--host=0.0.0.0"]

# Copy the code in
COPY app.py /usr/src/app/app.py
