# The stencila/cloud Docker container image

FROM node:10

ENV DEBIAN_FRONTEND noninteractive
ENV NPM_CONFIG_LOGLEVEL warn

# Install kubctrl for accessing the Kubernetes API
# See https://kubernetes.io/docs/tasks/access-application-cluster/access-cluster/#accessing-the-api-from-a-pod
# For latest release see https://github.com/kubernetes/kubernetes/releases
RUN curl -L -o /bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v1.13.3/bin/linux/amd64/kubectl \
 && chmod +x /bin/kubectl

# Run as non-root user
RUN useradd -m cloud
WORKDIR /home/cloud
USER cloud

# Just copy `package.json` for `npm install` so that it
# is not re-run when an unrelated file is changed
COPY package.json .
RUN npm install --production

# Now copy over everything
COPY . .

# Expose server.js port
EXPOSE 2000

CMD ["bash", "cmd.sh"]
