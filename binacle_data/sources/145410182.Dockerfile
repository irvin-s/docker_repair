FROM erlang:18.2
RUN apt-get update
RUN apt-get install -y mg nano postgresql-9.4 sqitch sudo vim

# We have to explicitly set the LD path for this lib -
# when it's built in a container, the rpath is not correctly set
# The below works for now in conjunction with 'ldconfig' - we'll needd to look closer at
# PWD handling in erlzmq to resolve it.
RUN echo /srv/_build/default/lib/erlzmq/deps/local/lib > /etc/ld.so.conf.d/erlzmq_drv.conf

# Use /srv so that we don't have to deal with .bash_history and other dotfiles getting
# created as root in the project directory
WORKDIR /srv
CMD /etc/init.d/postgresql start && \
    (cd /srv/pushy-server-schema && sudo -u postgres make setup_dev) && \
    ldconfig && \
    make install && \
    bash
