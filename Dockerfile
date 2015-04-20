FROM alpine:3.1
MAINTAINER Damien DUPORTAL <damien.duportal@gmail.com>

ENV BATS_VERSION 0.4.0

ADD https://github.com/sstephenson/bats/archive/v${BATS_VERSION}.tar.gz /tmp/

RUN apk --update add make bash curl \
	&& tar -x -z -f /tmp/v${BATS_VERSION}.tar.gz -C /tmp/ \
	&& bash /tmp/bats-${BATS_VERSION}/install.sh /usr/local \
	&& rm -rf /tmp/*

ENTRYPOINT ["/usr/local/bin/bats"]

CMD ["-v"]
