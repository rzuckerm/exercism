#!/bin/bash
set -ex
black -l 120 .

if [ -e pylintrc ]
then
    pylint *.py
else
    pylint --rcfile ../pylintrc *.py
fi

pytest -vvl

