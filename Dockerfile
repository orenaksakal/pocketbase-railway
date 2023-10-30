FROM alpine:latest

ARG TARGETOS
ARG TARGETARCH
ARG VERSION=0.19.1

ENV BUILDX_ARCH="${TARGETOS:-linux}_${TARGETARCH:-amd64}"

# Install the dependencies
RUN apk add --no-cache \
    ca-certificates \
    unzip

# RUN wget https://github.com/pocketbase/pocketbase/releases/download/v${VERSION}/pocketbase_${VERSION}_${BUILDX_ARCH}.zip /tmp/pb.zip
# RUN unzip /tmp/pb.zip -d /usr/local/bin/pocketbase/

RUN wget https://github.com/pocketbase/pocketbase/releases/download/v${VERSION}/pocketbase_${VERSION}_${BUILDX_ARCH}.zip \
    && unzip pocketbase_${VERSION}_${BUILDX_ARCH}.zip -d /usr/local/bin/pocketbase/
RUN chmod +x /usr/local/bin/pocketbase/pocketbase

WORKDIR /usr/local/bin/pocketbase
COPY . .

EXPOSE 8090

CMD ["/usr/local/bin/pocketbase/pocketbase", "serve", "--http=0.0.0.0:8090", "--dir=/pb_data", "--publicDir=/pb_public"]
