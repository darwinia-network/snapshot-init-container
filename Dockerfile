FROM alpine:3

RUN apk add --no-cache \
    curl \
    p7zip \
    bash

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD []
