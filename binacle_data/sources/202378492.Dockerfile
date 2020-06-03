# My Image
FROM jansanchez/nocker-wheezy

# Declare Arguments
ARG USER
ARG GID
ARG UID

# Create a new group account with Args
RUN groupadd --gid $GID $USER \
  && useradd --uid $UID --gid $USER --shell /bin/bash --create-home $USER

# App name
ENV APP_NAME app

ENV USER_PATH /home/$USER/
ENV APP_PATH $USER_PATH$APP_NAME/

# Switch to $USER
USER $USER

# App Folder
RUN mkdir -p $APP_PATH \
    && chmod -R 775 $APP_PATH

# Set Workdir
WORKDIR $APP_PATH

# Expose default port
EXPOSE 3000

# Exec node
CMD node

# For run a container and start a Bash session use 'bash' or /bin/bash
# i.e. docker run -it --rm image_name bash
