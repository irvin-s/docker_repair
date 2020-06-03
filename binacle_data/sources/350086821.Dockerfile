FROM python:3.6
WORKDIR /app
ADD setup.py .
RUN pip install -e .
ADD . .
EXPOSE 4444
CMD rarbg
