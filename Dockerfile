FROM python:3.6-alpine

# basic flask environment
#RUN apk add --no-cache bash git uwsgi uwsgi-python3 && pip3 install --upgrade pip && pip3 install flask
#RUN apt-get update -y && apt-get install -y python-pip python-dev

COPY ./requirements.txt /app/requirements.txt

WORKDIR /app

RUN pip install -r requirements.txt

COPY . /app

ENTRYPOINT [ "python" ]

CMD ["hello.py" ]
