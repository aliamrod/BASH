#!/bin/bash

# Snake game in Bash script

# Terminal dimensions
COLS=$(tput cols)
LINES=$(tput lines)

# Game settings
SNAKE_LENGTH=3
SNAKE_HEAD="O"
SNAKE_BODY="o"
FOOD="@"

# Initial snake position and direction
snake_x=$((COLS / 2))
snake_y=$((LINES / 2))
snake_dir="right"

# Initial score
score=0

# Function to display the game board
display_board() {
  clear

  # Draw snake head
  tput cup $snake_y $snake_x
  echo -n "$SNAKE_HEAD"

  # Draw snake body
  for ((i = 1; i <= SNAKE_LENGTH - 1; i++)); do
    case "$snake_dir" in
    "right")
      tput cup $snake_y $((snake_x - i))
      ;;
    "left")
      tput cup $snake_y $((snake_x + i))
      ;;
    "up")
      tput cup $((snake_y + i)) $snake_x
      ;;
    "down")
      tput cup $((snake_y - i)) $snake_x
      ;;
    esac
    echo -n "$SNAKE_BODY"
  done

  # Draw food
  tput cup $food_y $food_x
  echo -n "$FOOD"

  # Display score
  tput cup 0 0
  echo -n "Score: $score"
}

# Function to generate new food position
generate_food() {
  food_x=$((RANDOM % COLS))
  food_y=$((RANDOM % LINES))
}

# Function to handle user input
handle_input() {
  read -rsn1 input

  case "$input" in
  "w")
    snake_dir="up"
    ;;
  "a")
    snake_dir="left"
    ;;
  "s")
    snake_dir="down"
    ;;
  "d")
    snake_dir="right"
    ;;
  "q")
    gameover=1
    ;;
  esac
}

# Initialize game
generate_food
display_board

# Main game loop
gameover=0
while [ $gameover -eq 0 ]; do
  # Handle user input
  handle_input

  # Update snake position
  case "$snake_dir" in
  "right")
    snake_x=$((snake_x + 1))
    ;;
  "left")
    snake_x=$((snake_x - 1))
    ;;
  "up")
    snake_y=$((snake_y - 1))
    ;;
  "down")
    snake_y=$((snake_y + 1))
    ;;
  esac

  # Check if the snake hit the food
  if [ $snake_x -eq $food_x ] && [ $snake_y -eq $food_y ]; then
    SNAKE_LENGTH=$((SNAKE_LENGTH + 1))
    score=$((score + 1))
    generate_food
  fi

  # Check if the snake hit the walls
  if [ $snake_x -lt 0 ] || [ $snake_x -ge $COLS ] || [ $snake_y -lt 0 ] || [ $snake_y -ge $LINES ]; then
    gameover=1
  fi

  # Check if the snake hit itself
  for ((i = 1; i <= SNAKE_LENGTH - 1; i++)); do
    case "$snake_dir" in
    "right")
      if [ $snake_x -eq $((
