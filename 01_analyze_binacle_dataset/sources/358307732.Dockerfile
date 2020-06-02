FROM python:2.7

ENV INSTANCE=docker

# Download and install wkhtmltopdf
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install sudo
RUN sudo apt-get install -y xvfb
RUN sudo apt-get -y install python-pandas
#RUN sudo apt-get remove -y wkhtmltopdf

# The version for local Debian env
RUN sudo apt-get install -y xfonts-75dpi
RUN wget http://download.gna.org/wkhtmltopdf/0.12/0.12.2.1/wkhtmltox-0.12.2.1_linux-jessie-amd64.deb
RUN sudo dpkg -i wkhtmltox-0.12.2.1_linux-jessie-amd64.deb
RUN rm wkhtmltox-0.12.2.1_linux-jessie-amd64.deb

# The version for server Ubuntu env
# RUN wget http://download.gna.org/wkhtmltopdf/0.12/0.12.2.1/wkhtmltox-0.12.2.1_linux-trusty-amd64.deb
# RUN sudo dpkg -i wkhtmltox-0.12.2.1_linux-trusty-amd64.deb
# RUN rm wkhtmltox-0.12.2.1_linux-trusty-amd64.deb

COPY ./requirements.txt /tmp/
RUN pip install --requirement /tmp/requirements.txt

WORKDIR '/rhizome'
