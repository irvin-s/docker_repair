# Use any image as your base image, or "scratch"
# Add fwatchdog binary via https://github.com/openfaas/faas/releases/
# Then set fprocess to the process you want to invoke per request - i.e. "cat" or "my_binary"

# FROM ...
# ADD https://...
# ENV fprocess=./my_binary
# CMD ["fwatchdog"]

FROM functions/alpine:latest
ENV fprocess "/bin/cat"