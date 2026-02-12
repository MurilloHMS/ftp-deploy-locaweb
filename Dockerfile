FROM alpine:3.19

COPY LICENSE README.md /

RUN apk --no-cache add lftp ca-certificates

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
