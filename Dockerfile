FROM alpine:3.7
LABEL Maintainer="Damien DUPORTAL <damien.duportal@gmail.com>"

ENV BATS_VERSION 0.4.0

WORKDIR /tests

RUN apk add --no-cache \
    bash \
    curl \
  && curl -sSL -o "/tmp/v${BATS_VERSION}.tgz" \
    "https://github.com/bats-core/bats-core/archive/v${BATS_VERSION}.tar.gz" \
  && tar -xzf "/tmp/v${BATS_VERSION}.tgz" -C /tmp/ \
  && bash "/tmp/bats-core-${BATS_VERSION}/install.sh" /opt/bats \
  && ln -s /opt/bats/libexec/bats /sbin/bats

ENTRYPOINT ["/sbin/bats"]

CMD ["-v"]
