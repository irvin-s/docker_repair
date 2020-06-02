FROM codeforafrica/hurumap:0.6.0

# Set env variables used in this Dockerfile
# HURUmap App and Django settings
ENV HURUMAP_APP=${HURUMAP_APP:-dominion}
ENV DJANGO_SETTINGS_MODULE=${HURUMAP_APP:-dominion}.settings
# Local directory with project source
ENV APP_SRC=.
# Directory in container for all project files
ENV APP_SRVHOME=/src
# Directory in container for project source files
ENV APP_SRVPROJ=/src/hurumap-apps

# Add application source code to SRCDIR
ADD $APP_SRC $APP_SRVPROJ

# Copy entrypoint script into the image
WORKDIR $APP_SRVPROJ

CMD [ "--name", "$HURUMAP_APP", "--reload", "hurumap.wsgi:application" ]
