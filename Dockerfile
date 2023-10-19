FROM python:3.10-slim

WORKDIR /usr/src/fansly

COPY ./Fansly .

RUN apt-get update && apt-get install -y --no-install-recommends \
  python3-tk \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && sed -i '/Press Enter to close/d' fansly_downloader.py
    
RUN python -m pip install -r ./requirements.txt --no-cache-dir

CMD [ "python", "fansly_downloader.py" ]
