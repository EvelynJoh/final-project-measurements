# das ist das offizelle Image von Python, ein minimales Imgage, basier auf der neueren Debian-Version. Ist sehr schlank, reicht um Python auszuführen
FROM python:3.9-slim-bullseye

# erzeugt das Verzeichnis im Container
WORKDIR /app

# Kopiert alle Abhängigkeiten aud der requirements.txt
COPY requirements.txt .

# die runtergeladenen Pakete sollen nicht im Cache abgelegt werden, deshalb --"no-cache-dir"
RUN pip3 install --no-cache-dir -r requirements.txt

# der bereits geschrieben Code bzw. App Code soll in das erzeugte Verzeichnis kopiert werden
COPY . .

# die Umgebungsvariablen für Flask sollen hiermit gesetzt werden
ENV FLASK_RUN_HOST=0.0.0.0

# 5000 ist der Port auf dem die App laufen soll
EXPOSE 5000

#sobald der Container läuft, soll Flast gestartet werden
CMD ["flask", "run"]