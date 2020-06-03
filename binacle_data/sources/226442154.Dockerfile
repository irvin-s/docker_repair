FROM taller/drupal-node

# Build-time configuration.
# -------------------------
# This is mostly useful to override on CIs.

ARG APP_NAME=drupal
ARG GROUP_ID=1000
ARG USER_ID=1000


# Configure environment.
# ----------------------

ENV APP_NAME=${APP_NAME}
ENV GROUP_ID=${GROUP_ID}
ENV GROUP_NAME=${APP_NAME} USER_ID=${USER_ID} USER_NAME=${APP_NAME}


# Create group and user.
# ----------------------

RUN groupadd --gid ${GROUP_ID} ${GROUP_NAME}                                                                          \
    && echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers                                                           \
    && useradd -u ${USER_ID} -G users,www-data,sudo -g ${GROUP_NAME} -d /${APP_NAME} --shell /bin/bash -m ${APP_NAME} \
    && echo "secret\nsecret" | passwd ${USER_NAME}


# Import files.
# -------------

COPY ./.bashrc /${APP_NAME}/.bashrc
RUN chown ${USER_NAME}:${GROUP_NAME} /${APP_NAME}/.bashrc


# Make site available.
# --------------------

RUN rm -Rf /var/www/drupal \
    && ln -s /${USER_NAME}/app/web /var/www/drupal


# Setup user and initialization directory.
# ----------------------------------------

USER ${USER_NAME}
WORKDIR /${USER_NAME}/app


# Install prestissimo for faster composer installs.
# -------------------------------------------------

RUN sudo cp -R /root/.composer /${USER_NAME}/.composer \
    && sudo chown ${USER_NAME}:${GROUP_NAME} -R /${USER_NAME}/.composer


# Configure entrypoint.
# ---------------------

COPY ./entrypoint.sh /etc/entrypoint.sh
RUN sudo chmod +x /etc/entrypoint.sh
CMD ["/bin/bash"]
ENTRYPOINT ["/etc/entrypoint.sh"]
