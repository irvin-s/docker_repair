FROM ubuntu:latest
RUN export DEBIAN_FRONTEND=noninteractive
# Update APT
RUN apt-get update
# We need timezone for tk, so do that here
RUN apt-get install -y tzdata
# Set the timezone
RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata
RUN apt-get install -y \
    python3 \ 
    python3-pip \
    python3-setuptools \
    python3-tk
COPY . /
RUN pip3 install -r requirements.txt
CMD ["python3", "xtree_plan.py"]
