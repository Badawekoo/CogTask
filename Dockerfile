FROM python:3.6-alpine

# basic flask environment
# We copy just the requirements.txt first to leverage Docker cache
COPY ./requirements.txt /app/requirements.txt

# Let our working directory /app
WORKDIR /app

# Install the needed packages
RUN pip install -r requirements.txt

# Copy our code to the working directory
COPY . /app

# Configures the container to run as an executable
ENTRYPOINT [ "python" ]

CMD ["hello.py" ]
