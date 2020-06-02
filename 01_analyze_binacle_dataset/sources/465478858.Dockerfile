FROM elementaryrobotics/atom

# Add in the code
ADD . /code

# Change over to the code directory
WORKDIR /code

# Build
RUN make

# And finally set up the LD_LIBRARY_PATH on the system s.t.
#   our binaries work as expected
ENV LD_LIBRARY_PATH /lib:/usr/local/lib

# RUn the element
CMD ["./build/waveform"]
