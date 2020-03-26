# Dockerfile
FROM python

COPY config.ini solution.py file_handle.py /src/
CMD ["python", "/src/file_handle.py"]
