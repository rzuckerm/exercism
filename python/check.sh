#!/bin/bash
set -ex
black -l 120 .
pylint *.py
pytest -vvl

