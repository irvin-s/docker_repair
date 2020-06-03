# Dockerfile.build represents the build environment of the driver, used during
# the development phase to test and in CI to build and test.

# The prefered base image is the lastest stable Alpine image, if alpine doesn't
# meet the requirements you can switch the from to the latest stable slim
# version of Debian (eg.: `debian:jessie-slim`).
FROM bblfsh/go-driver
