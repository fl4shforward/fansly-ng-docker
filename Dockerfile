FROM python:3.12-alpine

WORKDIR /usr/src/fansly-ng

COPY ./fansly-downloader-ng .

RUN apk update && apk add --no-cache \
    # gfortran \
    # build-base \
    # pkgconfig \
    # openblas-dev \
    # linux-headers \
    python3-tkinter \
    && rm -rf /var/cache/apk/*

RUN python -m pip install -r ./requirements.txt --no-cache-dir && chmod -R 777 /usr/src/fansly-ng && mkdir /.pyffmpeg && chmod 777 /.pyffmpeg
RUN sed -i 's/https:\/\/apiv3.fansly.com\/api\/v1\/group/https:\/\/apiv3.fansly.com\/api\/v1\/messaging\/groups/' /usr/src/fansly-ng/api/fansly.py
RUN sed -i "s/\['response'\]\['groups'\]/['response']['aggregationData']['groups']/" /usr/src/fansly-ng/download/messages.py

CMD [ "python", "fansly_downloader_ng.py", "-ni", "-npox" ]
