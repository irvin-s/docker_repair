FROM service_base
COPY /service /
CMD ["python", "service.py"]
