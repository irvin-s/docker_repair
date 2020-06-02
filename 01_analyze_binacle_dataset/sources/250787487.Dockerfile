# Based on the mozilla-central lint image, as it is nice and small.
FROM quay.io/mozilla/lint

# Add git to the image.
RUN apt-get update -y && apt-get install -y git
