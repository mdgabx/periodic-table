#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table -t --no-align -c"

echo "Please provide an element as an argument."

echo $1;
