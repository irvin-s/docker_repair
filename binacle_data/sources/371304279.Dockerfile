FROM k8spracticalguide/debian:9-slim AS downloader
ARG MM_VERSION=4.10.2
ADD mm_entrypoint.sh .
ADD https://releases.mattermost.com/$MM_VERSION/mattermost-team-$MM_VERSION-linux-amd64.tar.gz .
RUN tar -zxvf ./mattermost-team-$MM_VERSION-linux-amd64.tar.gz

FROM k8spracticalguide/debian:9-slim
WORKDIR /mm
COPY --from=downloader /mattermost /mm_entrypoint.sh ./
RUN apt-get update && apt-get install -y procps
RUN chmod +x mm_entrypoint.sh
ENTRYPOINT /mm/mm_entrypoint.sh
