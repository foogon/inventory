from node:7-alpine

# Use dumb-init so that our node app does not have to take on PID 1
# init system responsibilities. To install via wget we need certificates
# installed temporarially. References:
#
# https://github.com/Yelp/dumb-init
# https://github.com/gliderlabs/docker-alpine/issues/218

ENV DUMB_INIT_VERSION 1.2.0
RUN apk add --no-cache --virtual .bootstrap-deps wget ca-certificates \
    && wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v${DUMB_INIT_VERSION}/dumb-init_${DUMB_INIT_VERSION}_amd64 \
    && chmod +x /usr/local/bin/dumb-init \
    && apk del .bootstrap-deps

workdir /source

copy package.json .
run npm install

copy . .
run npm run build

entrypoint ["dumb-init", "--"]
cmd ["npm", "run", "start"]
