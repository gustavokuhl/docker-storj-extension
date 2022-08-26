#!/usr/bin/env bash
set -ex
docker buildx build --load -t ghcr.io/elek/docker-storj-extension:1.0.0-nightly-$1 .
docker extension update ghcr.io/elek/docker-storj-extension:1.0.0-nightly-$1


