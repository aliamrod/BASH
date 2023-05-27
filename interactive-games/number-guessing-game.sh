#! /bin/bash

# Generate a random number between 1 and 100
target=$((RANDOM % 100 + 1))

echo "Welcome to the Number Guessing Game!"

# Function to check if the guess is correct
check_guess(){
  local guess=$1
  
  if ((guess==target)); then
    echo "Congratulations! You guessed the correct number."
      exit
    elif ((guess < target )); then
      echo "Too low! Try guessing a higher number."
    else
      echo "Too high! Try guessing a lower number."
    fi
  }

# Main game loop
while true; do
  read -p "Guess a number between 1 and 100: " guess
  
  if [[ $guess =~ ^[0-9]+$ ]]; then
    check_guess $guess
  else
    echo "Invalid input. Please enter a valid number."
  fi
done
  
# The script is saved as `number-guessing-game.sh` and made executable by calling `chmod +x number-guessing-game.sh. 
# The script is consequently run from the terminal. The game will prompt users to guess a number between 1 and 100. 
