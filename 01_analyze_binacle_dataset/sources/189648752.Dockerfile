FROM library/python

WORKDIR /home/chromedriver_installer

ADD . /home/chromedriver_installer

# Chromedriver 2.29 complains on Ubuntu about
# missing libnss3 and libgconf-2-4 libraries.
RUN apt-get -yqq update
RUN apt-get -yqq install libnss3 libgconf-2-4

RUN pip install -q -r requirements.txt

CMD tox