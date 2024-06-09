# Use the official lightweight Python image.
# https://hub.docker.com/_/python
FROM python:3.9-slim

# Allow statements and log messages to be immediately visible.
ENV PYTHONUNBUFFERED True

# Set the working directory.
WORKDIR /app

# Install system dependencies for psycopg2 and other packages.
RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    build-essential \
    libssl-dev \
    libffi-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy the current directory contents into the container at /app.
COPY . /app

# Install any needed packages specified in requirements.txt.
RUN pip install --no-cache-dir -r requirements.txt

# Make port 8501 available to the world outside this container.
EXPOSE 8501

# Run Streamlit when the container launches.
CMD ["streamlit", "run", "ajout_exercice.py"]
