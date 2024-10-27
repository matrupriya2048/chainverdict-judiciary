# Use a lightweight Python image
FROM python:3.10-slim

# Update and install dependencies
RUN apt-get update && \
    apt-get install -y build-essential wget libsqlite3-dev && \
    wget https://www.sqlite.org/2023/sqlite-autoconf-3430100.tar.gz && \
    tar -xvf sqlite-autoconf-3430100.tar.gz && \
    cd sqlite-autoconf-3430100 && \
    ./configure && make && make install && cd .. && rm -rf sqlite-autoconf-3430100*

# Set up a directory for the app
WORKDIR /app

# Copy application files to the container
COPY . /app

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Expose the necessary port (default Streamlit port)
EXPOSE 8501

# Run the Streamlit app
CMD ["streamlit", "run", "main4.py"]
