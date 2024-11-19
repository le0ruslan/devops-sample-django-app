FROM python:3.8-slim

RUN apt update && \
    apt install -y build-essential && \
    pip install --upgrade pip && \
    pip install uwsgi

WORKDIR /app

COPY . .

RUN pip install -r requirements.txt

EXPOSE 8000

ENV DJANGO_DB_HOST=db
ENV DJANGO_DB_NAME=app
ENV DJANGO_DB_USER=worker
ENV DJANGO_DB_PASS=worker
ENV DJANGO_DB_PORT=5432
ENV DJANGO_DEBUG=False


CMD ["uwsgi", "--http", ":8000", "--module", "parrotsite.wsgi", "--static-map", "/static=static"]
