# Image: abacosamples/docker_ps
# This image should be registered with the privileged flag.
from abacosamples/base-ubu

ADD requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

ADD docker_ps.py /docker_ps.py

CMD ["python", "/docker_ps.py"]
