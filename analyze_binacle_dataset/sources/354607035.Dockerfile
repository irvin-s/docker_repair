# Inherit from Heroku's stack
FROM heroku/cedar:14

# Internally, we arbitrarily use port 3000
ENV PORT 3000
# Which version of Python?
ENV PYTHON_VERSION python-2.7.11

# Add Python binaries to path.
ENV PATH /app/.heroku/python/bin/:$PATH

# Create some needed directories
RUN mkdir -p /app/.heroku/python /app/.profile.d
WORKDIR /app/user

# `init` is kept out of /app so it won't be duplicated on Heroku
# Heroku already has a mechanism for running .profile.d scripts,
# so this is just for local parity
COPY ./init /usr/bin/init

# Install Python
RUN curl -s https://lang-python.s3.amazonaws.com/cedar-14/runtimes/$PYTHON_VERSION.tar.gz | tar zx -C /app/.heroku/python

# Install Pip & Setuptools
RUN curl -s https://bootstrap.pypa.io/get-pip.py | /app/.heroku/python/bin/python


# Export the Python environment variables in .profile.d
RUN echo 'export PATH=$HOME/.heroku/python/bin:$PATH PYTHONUNBUFFERED=true PYTHONHOME=/app/.heroku/python LIBRARY_PATH=/app/.heroku/vendor/lib:/app/.heroku/python/lib:$LIBRARY_PATH LD_LIBRARY_PATH=/app/.heroku/vendor/lib:/app/.heroku/python/lib:$LD_LIBRARY_PATH LANG=${LANG:-en_US.UTF-8} PYTHONHASHSEED=${PYTHONHASHSEED:-random} PYTHONPATH=${PYTHONPATH:-/app/user/}' > /app/.profile.d/python.sh
RUN chmod +x /app/.profile.d/python.sh

ONBUILD ADD requirements.txt /app/user/
ONBUILD RUN /app/.heroku/python/bin/pip install -r requirements.txt
ONBUILD ADD . /app/user/

ENTRYPOINT ["/usr/bin/init"]
