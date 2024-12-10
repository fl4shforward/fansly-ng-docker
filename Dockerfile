FROM python:3.13-alpine

WORKDIR /usr/src/fansly-ng

COPY ./fansly-downloader-ng .

RUN apk update && apk add --no-cache \
    tk \
    build-base \
    libffi-dev \
    freetype-dev \
    fribidi-dev \
    harfbuzz-dev \
    jpeg-dev \
    lcms2-dev \
    libimagequant-dev \
    openjpeg-dev \
    tcl-dev \
    tiff-dev \
    tk-dev \
    zlib-dev \
    && rm -rf /var/cache/apk/*

RUN python -m pip install -r ./requirements.txt --no-cache-dir && chmod -R 777 /usr/src/fansly-ng && mkdir /.pyffmpeg && chmod 777 /.pyffmpeg
RUN sed -i 's/https:\/\/apiv3.fansly.com\/api\/v1\/group/https:\/\/apiv3.fansly.com\/api\/v1\/messaging\/groups/' /usr/src/fansly-ng/api/fansly.py
RUN sed -i "s/\['response'\]\['groups'\]/['response']['aggregationData']['groups']/" /usr/src/fansly-ng/download/messages.py

CMD [ "python", "fansly_downloader_ng.py", "-ni", "-npox" ]
