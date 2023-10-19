FROM python:3.10-slim

WORKDIR /usr/src/fansly

COPY ./Fansly .

RUN python -m pip install -r ./requirements.txt

CMD [ "python", "./fansly_downloader.py" ]
