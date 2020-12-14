FROM python:latest

# Define the work directory of this project to app folder 
# (and create a folder named "app" because it didn't exist)
WORKDIR /app

COPY requirements.txt .

RUN pip install -r requirements.txt

RUN wget https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh -P /scripts
RUN chmod +x /scripts/wait-for-it.sh
ENTRYPOINT ["/scripts/wait-for-it.sh", "db:5432", "--"]

# Copy all files to the work directory
COPY . .

# Install the required import
EXPOSE 5000

# Command to execute the python script
CMD ["python", "app.py" ,"runserver",  "--host=0.0.0.0",  "--threaded"]
