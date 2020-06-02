FROM rangle/clusternator-node-$NODE_MAJOR_VERSION:$NODE_FULL_VERSION

# Set up a place for your applications to live.
RUN mkdir /home/app
COPY . /home/app/
RUN chown -R swuser:swuser /home/app

# install the application
USER swuser
RUN cd /home/app/; npm set progress=false; npm install

## Expose the ports
EXPOSE $EXTERNAL_PORT

CMD ["/home/app/.clusternator/serve.sh"]
