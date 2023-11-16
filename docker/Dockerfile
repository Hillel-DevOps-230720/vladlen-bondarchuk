# Use an official Python runtime as a parent image
FROM python:3.8-slim

# Install build dependencies, including gcc
RUN apt-get update \
    && apt-get install -y default-libmysqlclient-dev gcc pkg-config\
    && rm -rf /var/lib/apt/lists/*

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Make port 8000 available to the world outside this container
EXPOSE 8000

# Define environment variable
ENV MYSQL_HOST "db_server"

# Run app.py when the container launches
ENTRYPOINT ["python", "app.py"]

