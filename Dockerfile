FROM alpine:3

RUN apk add --no-cache \
    bash \
    wget \
    p7zip

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD []
