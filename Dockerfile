FROM python:3.10-slim

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt requirements-app.txt ./

RUN pip install --no-cache-dir -r requirements.txt -r requirements-app.txt

COPY . .

RUN python scripts/download_model.py --models all

EXPOSE 7860
EXPOSE 8080

#COPY start.sh /app/start.sh
#RUN chmod +x /app/start.sh
#CMD ["/bin/bash", "/app/start.sh"]

CMD ["python3", "-u", "app.py", "--host", "0.0.0.0", "--port", "7860"]
#CMD ["python3", "-u", "deploy_api.py"]


