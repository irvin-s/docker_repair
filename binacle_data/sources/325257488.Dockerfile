FROM python:3.7

ENV PYTHONUNBUFFERED 1

RUN mkdir /app
WORKDIR /app

# Copying & Installing python requirements
COPY requirements.txt /app/
RUN pip install -r requirements.txt

# Syncing the source of the application
COPY . /app/

EXPOSE 8000

# Run the gunicorn web server
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "pollsapi.wsgi"]
