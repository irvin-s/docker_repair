# Image: abacosamples/py_test
# This image can be used to test basic the basic functionality of the Python SDK against an Abaco instance.
from abacosamples/base-ubu

ADD myactor.py /myactor.py

CMD ["python", "/myactor.py"]
