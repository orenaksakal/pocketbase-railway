FROM alpine:latest

ARG TARGETOS
ARG TARGETARCH
ARG VERSION=0.10.4

ENV BUILDX_ARCH="${TARGETOS:-linux}_${TARGETARCH:-amd64}"

# Install the dependencies
RUN apk add --no-cache \
    ca-certificates \
    unzip

RUN wget https://github.com/pocketbase/pocketbase/releases/download/v${VERSION}/pocketbase_${VERSION}_${BUILDX_ARCH}.zip /tmp/pb.zip
RUN unzip /tmp/pb.zip -d /pb/

EXPOSE 8090

CMD ["/pb/pocketbase", "serve", "--http=0.0.0.0:8090"]
