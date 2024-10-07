#!/bin/bash

# Start app.py
python3 -u app.py --host 0.0.0.0 --port 7860 &

# Start deploy_api.py
python3 -u deploy_api.py

# Wait for any process to exit
wait -n

# Exit with status of the process that exited first
exit $?
