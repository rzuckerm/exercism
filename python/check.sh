#!/bin/bash
black .
pylint *.py
pytest -vvl

