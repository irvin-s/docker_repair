FROM golang:1.7

# Install virtualenv
RUN curl https://bootstrap.pypa.io/get-pip.py | python
RUN pip install virtualenv

# Install glide
RUN curl https://glide.sh/get | sh
