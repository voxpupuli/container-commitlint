FROM docker.io/library/node:24.10.0-alpine3.21 AS build

WORKDIR /npm
COPY package.json /npm

RUN npm install

###############################################################################

FROM docker.io/library/node:24.10.0-alpine3.21 AS final

LABEL org.label-schema.maintainer="Voxpupuli Team <voxpupuli@groups.io>" \
      org.label-schema.vendor="Voxpupuli" \
      org.label-schema.url="https://github.com/voxpupuli/container-commitlint" \
      org.label-schema.name="Vox Pupuli Container for commitlint" \
      org.label-schema.license="AGPL-3.0-or-later" \
      org.label-schema.vcs-url="https://github.com/voxpupuli/container-commitlint" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.dockerfile="/Containerfile"

COPY Containerfile /
COPY container-entrypoint.sh /
COPY container-entrypoint.d /container-entrypoint.d
COPY --from=build /npm /npm

RUN apk update && apk upgrade \
    && apk add --no-cache --update bash git \
    && chmod +x /container-entrypoint.sh \
    # fix ENOGITREPO Not running from a git repository.
    && git config --global --add safe.directory '*'

WORKDIR /data

ENV PATH="$PATH:/npm/node_modules/.bin"
ENV NODE_OPTIONS="--use-openssl-ca"

ENTRYPOINT [ "/container-entrypoint.sh" ]
CMD [ "--last" ]
