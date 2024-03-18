import psutil
from flask import Flask, render_template

app = Flask(__name__)

@app.route("/")  # hier weise ich darauf hin, dass die App auf dem Home-Pfad ausgeführt wird
def index():
    cpu_percent = psutil.cpu_percent()
    mem_percent = psutil.virtual_memory().percent
    Message = None
    if cpu_percent > 80 or mem_percent > 80: # sollte die Auslastung zu hoch sein, wird eine Message gesendet. 
        Message = "High CPU or Memory Utilization detected. Please scale up"
    return render_template("index.html", cpu_percent=cpu_percent, mem_percent=mem_percent, message=Message)  # an dieser stelle ist der Return an die index.html gerendert

if __name__ == '__main__': # __name__ ist der Name der App, in Zeile 4
    app.run(debug=True, host='0.0.0.0')