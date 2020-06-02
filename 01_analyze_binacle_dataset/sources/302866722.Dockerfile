FROM python:3.6.8
ENV PYTHONUNBUFFERED 1

RUN apt-get update && apt-get -y install postgresql
RUN pip install pipenv

# Expose is NOT supported by Heroku
# EXPOSE 8000

# Run the image as a non-root user

CMD pip --version
