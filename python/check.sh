#!/bin/bash
set -ex
black .
pylint *.py
pytest -vvl

