
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
    libffi-dev \
    libatlas-base-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy the current directory contents into the container at /app.
COPY . /app

# Install any needed packages specified in requirements.txt.
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Make port 8501 available to the world outside this container.
EXPOSE 8501

# Run Streamlit when the container launches.
CMD ["streamlit", "run", "ajout_exercice.py", "--server.port=8501", "--server.address=0.0.0.0"]
