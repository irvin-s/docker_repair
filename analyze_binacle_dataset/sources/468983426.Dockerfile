# qed_py3 is debian linux with buildpack-deps
# updated with all needed qed python dependencies
# Use 'version' ARG for grabbing correct qed_py3 base image.
# Defaults to 'latest' if not set.
ARG version=dev
FROM quanted/qed_py3:$version

# Install Python Dependencies
COPY . /src/

# Overwrite the uWSGI config
COPY uwsgi.ini /etc/uwsgi/

# Copy the project code
WORKDIR /src
EXPOSE 8080

# Ensure "docker_start" is executable
RUN chmod 755 /src/docker_start.sh
RUN pip freeze | grep Django

# TESTING INSTALLS
#RUN pip install distributed
#RUN pip install bokeh==0.13
#RUN pip install matplotlib
RUN pip install django-cors-headers

# Specific Docker-specific Django settings file (needed for collectstatic)
ENV DJANGO_SETTINGS_MODULE="settings_docker"

# Add project root to PYTHONPATH (needed to import custom Django settings)
ENV PYTHONPATH="/src"

# ENTRYPOINT ["sh /src/docker_start.sh"]
CMD ["sh", "/src/docker_start.sh"]
