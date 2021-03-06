FROM python:2.7

# Install requirements
WORKDIR /app
COPY ./requirements.txt /app
RUN pip install -r requirements.txt

# Install watchdog for auto restart on code changes
RUN pip install watchdog
