FROM node:23.1.0-alpine3.20 AS build

WORKDIR /npm
COPY package.json /npm

RUN npm install

###############################################################################

FROM node:23.1.0-alpine3.20 AS final

LABEL org.label-schema.maintainer="Voxpupuli Team <voxpupuli@groups.io>" \
      org.label-schema.vendor="Voxpupuli" \
      org.label-schema.url="https://github.com/voxpupuli/container-commitlint" \
      org.label-schema.name="Vox Pupuli Container for commitlint" \
      org.label-schema.license="AGPL-3.0-or-later" \
      org.label-schema.vcs-url="https://github.com/voxpupuli/container-commitlint" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.dockerfile="/Dockerfile"

COPY Dockerfile /
COPY docker-entrypoint.sh /
COPY docker-entrypoint.d /docker-entrypoint.d
COPY --from=build /npm /npm

RUN apk update && apk upgrade \
    && apk add --no-cache --update bash git \
    && chmod +x /docker-entrypoint.sh \
    # fix ENOGITREPO Not running from a git repository.
    && git config --global --add safe.directory '*'
    # && chmod +x /docker-entrypoint.d/*.sh

WORKDIR /data

ENV PATH="$PATH:/npm/node_modules/.bin"
ENV NODE_OPTIONS="--use-openssl-ca"

ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD [ "--last" ]
