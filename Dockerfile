FROM python:3.12-slim

RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    libpq-dev \
    build-essential \
    libssl-dev \
    libatlas-base-dev \
    zlib1g-dev \
    libjpeg-dev \
    libpng-dev \
    libffi-dev \
    wget \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . /app

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 80

CMD ["streamlit", "run", "main.py"]
