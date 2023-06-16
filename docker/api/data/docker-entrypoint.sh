#! /bin/bash

MOUNT=/attachments

# make attachment directories (if required)
mkdir -p \
    $MOUNT/general_action \
    $MOUNT/incident_attachments \
    $MOUNT/training_attachments \
    $MOUNT/documents_attachments \
    $MOUNT/decision_log \
    $MOUNT/lessons_learned \
    $MOUNT/decision_log

python3 -m venv /opt/api
exec $@
