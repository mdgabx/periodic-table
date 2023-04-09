#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then

  echo "Please provide an element as an argument."

else 
  # when there is an argument

  # If you run ./element.sh 1, ./element.sh H, or ./element.sh Hydrogen, it should output only The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.

  if [[ $1 =~ ^[0-9]*$ ]]
  then
 
    ATOMIC_NUMBER_ARG=$1

    ATOMIC_RESULT=$($PSQL "SELECT atomic_number, type, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id, symbol, name FROM properties INNER JOIN elements USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER_ARG;")

    if [[ -z $ATOMIC_RESULT ]]
    then

      echo "I could not find that element in the database."

    else 

      echo "$ATOMIC_RESULT" | while IFS='|' read -r ATOMIC_NUMBER TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE_ID SYMBOL NAME
      do
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
      done 
    fi

  elif [[ $1 =~ (^[A-Z][a-z]{0,2}$) ]]
   then

    SYMBOL_ARG=$1

    SYMBOL_RESULT=$($PSQL "SELECT atomic_number, type, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id, symbol, name FROM properties INNER JOIN elements USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol='$SYMBOL_ARG';")
  
    if [[ -z $SYMBOL_RESULT ]]
    then
       
       echo "I could not find that element in the database."
    
    else 

      echo "$SYMBOL_RESULT" | while IFS='|' read -r ATOMIC_NUMBER TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE_ID SYMBOL NAME
      do
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
      done
    fi

  else

    NAME_ARG=$1

    NAME_RESULT=$($PSQL "SELECT atomic_number, type, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id, symbol, name FROM properties INNER JOIN elements USING(atomic_number) INNER JOIN types USING(type_id) WHERE name='$NAME_ARG';")

    if [[ -z $NAME_RESULT ]]
    then

      echo "I could not find that element in the database."

    else 

      echo "$NAME_RESULT" | while IFS='|' read -r ATOMIC_NUMBER TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE_ID SYMBOL NAME
      do
       echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
      done

    fi


  fi
    
fi
