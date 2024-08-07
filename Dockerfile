FROM python:3.11-slim

WORKDIR /usr/src/fansly-ng

COPY ./fansly-downloader-ng .

RUN apt-get update && apt-get install -y --no-install-recommends \
  python3-tk \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN python -m pip install -r ./requirements.txt --no-cache-dir && chmod -R 777 /usr/src/fansly-ng && mkdir /.pyffmpeg && chmod 777 /.pyffmpeg

CMD [ "python", "fansly_downloader_ng.py", "-ni", "-npox" ]
