FROM node:lts

ENV HUGO_VERSION=0.140.0
RUN curl -o /tmp/hugo.tar.gz -L https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-$(uname -m | sed -e 's/aarch64/arm64/g').tar.gz \
    && tar -xf /tmp/hugo.tar.gz -C /tmp \
    && mkdir -p /usr/local/sbin \
    && mv /tmp/hugo /usr/local/sbin/hugo \
    && rm -rf /tmp/hugo* \
    && apt-get update && apt-get install -y \
      zopfli \
 && rm -rf /var/lib/apt/lists/*

COPY . /site
WORKDIR /site
RUN npm ci && ./build.sh

FROM nginx:stable-alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=0 /site/public /usr/share/nginx/html
