FROM alpine:latest as builder
RUN apk update && apk add --no-cache gcc make musl-dev linux-headers
RUN apk add libjodycode-dev --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing/

COPY ./jdupes .
RUN make ENABLE_DEDUPE=1 && make install

FROM alpine:latest as runner
RUN apk update && apk add --no-cache libjodycode --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing/

COPY --from=builder /usr/local/bin/jdupes /usr/local/bin/jdupes

ENTRYPOINT [ "/usr/local/bin/jdupes" ]
