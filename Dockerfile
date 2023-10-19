FROM python:3.10-slim

WORKDIR /usr/src/fansly

COPY ./Fansly .

RUN apt-get update && apt-get install -y \
  python3-tk \
  && rm -rf /var/lib/apt/lists/*
    
RUN python -m pip install -r ./requirements.txt

CMD [ "python", "./fansly_downloader.py" ]
