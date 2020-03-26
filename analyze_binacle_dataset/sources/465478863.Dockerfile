FROM elementaryrobotics/atom

# Want to copy over the contents of this repo to the code
#	section so that we have the source
ADD . /code

# Here, we'll build and install the code s.t. our launch script,
#	now located at /code/launch.sh, will launch our element/app

#
# TODO: build code
#

# Finally, specify the command we should run when the app is launched
WORKDIR /code
RUN chmod +x launch.sh
CMD ["./launch.sh"]
