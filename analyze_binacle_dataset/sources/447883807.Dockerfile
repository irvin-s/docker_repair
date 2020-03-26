FROM eu.gcr.io/dnt-docker-registry-public/sherpa-backend-base-image:1.0.3

# Copy application files
COPY . /sherpa/

# Compile translations
RUN DJANGO_SETTINGS_MODULE="" django-admin.py compilemessages

# Create version file
RUN echo ${BUILD_TAG} > /sherpa/sherpa/sherpa-version
