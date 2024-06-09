
FROM python:3.11-slim
# Allow statements and log messages to be immediately visible.
ENV PYTHONUNBUFFERED True

# Set the working directory.
WORKDIR /app

# Install system dependencies for psycopg2 and other packages.
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
    build-essential \
    libffi-dev \
    && rm -rf /var/lib/apt/lists/* \
    wget https://github.com/gohugoio/hugo/releases/download/v0.111.3/hugo_extended_0.111.3_Linux-64bit.deb && \
    dpkg -i hugo_extended_0.111.3_Linux-64bit.deb && \
    rm hugo_extended_0.111.3_Linux-64bit.deb

RUN pip install --upgrade setuptools


# Copy the current directory contents into the container at /app.
COPY . /app

# Install any needed packages specified in requirements.txt.
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

RUN hugo -d public


# Make port 8501 available to the world outside this container.
EXPOSE 8501

# Run Streamlit when the container launches.
CMD ["streamlit", "run", "ajout_exercice.py", "--server.port=8501", "--server.address=0.0.0.0"]
