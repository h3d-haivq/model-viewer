FROM node:15.5.0-buster

RUN apt-get update && \
    apt-get install -y --no-install-recommends git && \
    rm -rf /var/lib/apt/lists/* && \
    useradd -ms /bin/bash house3d && \
    mkdir /app && chown -R house3d:house3d /app 

USER house3d

WORKDIR /home/house3d
WORKDIR /app

RUN git clone --depth=1 https://github.com/h3d-haivq/model-viewer.git && \
    cd model-viewer && \
    npm install && \
    npm run bootstrap && \
    npm run build

WORKDIR /app/model-viewer/packages/space-opera

CMD ["./node_modules/.bin/http-server", "-gb", "-o", "/editor"]
