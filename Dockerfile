FROM node:17.7-alpine3.14 AS client-builder
WORKDIR /app/client
# cache packages in layer
COPY client/package.json /app/client/package.json
COPY client/yarn.lock /app/client/yarn.lock
ARG TARGETARCH
RUN yarn config set cache-folder /usr/local/share/.cache/yarn-${TARGETARCH}
RUN --mount=type=cache,target=/usr/local/share/.cache/yarn-${TARGETARCH} yarn
# install
COPY client /app/client
RUN --mount=type=cache,target=/usr/local/share/.cache/yarn-${TARGETARCH} yarn build

LABEL org.opencontainers.image.title="Storj Decentralized Docker Registry" \
    org.opencontainers.image.description="An extension to start a local registry backed by decentralized Storj." \
    org.opencontainers.image.vendor="Storj Labs" \
    com.docker.desktop.extension.api.version=">= 0.2.0" \
    com.docker.desktop.extension.icon="https://www.docker.com/wp-content/uploads/2022/03/Moby-logo.png" \
    com.docker.extension.detailed-description="<h1>Description</h1><p>This extension helps to start a local docker registry which is backed by Storj decentralized storage.</p>" \
    com.docker.extension.publisher-url="https://storj.io" \
    com.docker.extension.additional-urls='[{"title":"Storj decentralized cloud","url":"https://storj.io"}]' \
    com.docker.extension.changelog="<ul><li>Initial version</li></ul>"

COPY --from=client-builder /app/client/dist ui
COPY metadata.json .
