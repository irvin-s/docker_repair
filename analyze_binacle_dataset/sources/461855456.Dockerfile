FROM python:3.5
RUN mkdir /var/run/sshd
RUN chmod 0755 /var/run/sshd
RUN apt-get update && apt-get install -y libffi-dev ssh
RUN pip3 install tox
