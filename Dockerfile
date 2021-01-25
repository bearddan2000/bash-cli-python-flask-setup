FROM python:latest

COPY bin/ /app

WORKDIR /app

RUN ./setup.sh \
  && mv hello_world/app.py . \
  && pip install -r requirements.txt
