FROM python:3.11-slim

WORKDIR /usr/src/fansly-ng

COPY ./fansly-downloader-ng .

RUN apt-get update && apt-get install -y --no-install-recommends \
  python3-tk \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN python -m pip install -r ./requirements.txt --no-cache-dir && chmod -R 777 /usr/src/fansly-ng && mkdir /.pyffmpeg && chmod 777 /.pyffmpeg
RUN sed -i 's/https:\/\/apiv3.fansly.com\/api\/v1\/group/https:\/\/apiv3.fansly.com\/api\/v1\/messaging\/groups/' /usr/src/fansly-ng/api/fansly.py
RUN sed -i "s/\['response'\]\['groups'\]/['response']['aggregationData']['groups']/" /usr/src/fansly-ng/download/messages.py

CMD [ "python", "fansly_downloader_ng.py", "-ni", "-npox" ]
