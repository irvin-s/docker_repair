# Use an official Python runtime as a parent image
FROM ubuntu:17.10

# Set the working directory to /app
WORKDIR /app


# Install needed packages
RUN apt update -y
RUN apt-get install -y python3-pip strace
RUN pip3 install --trusted-host pypi.python.org sc2

# Alterantive for debugging python-sc2 issues
# RUN pip3 install -e python-sc2

# Create users
RUN useradd -ms /bin/bash user0 \
	&& useradd -ms /bin/bash user1

RUN groupadd -g 1500 sc2

RUN gpasswd -a user0 sc2
RUN gpasswd -a user1 sc2

RUN ln -s /StarCraftII /home/user0/StarCraftII \
	&& ln -s /StarCraftII /home/user1/StarCraftII

# Copy the current directory contents into the container at /app
ADD . /app

RUN chown -R user0 /app/repo0 \
	&& chown -R user1 /app/repo1 \
	&& chmod -R 700 /app/repo0 \
	&& chmod -R 700 /app/repo1 \
	&& ln -s /app/repo0 /home/user0/repo \
	&& ln -s /app/repo1 /home/user1/repo

# Run startup.py when the container launches
ENTRYPOINT python3 startup.py
