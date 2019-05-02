# MapMaker ADR
# Not present in the final product
# Alexander Schlesinger
#sprint 3 5/2/2019

# What is this?
 - This script is used to create new makes for the game. It take in the old target point and then randomly generates a new map. This is a core function of the game and allows it to be played infinitely if wished.

# Why python
  - The main reason this has been developed in python is because this is the language I'm most comfortable in. I wanted to first develop the logic in a language I'm capable in and then rebuild it in swift.

# Plan for the future
  - once again I will adapt this python code to work with the rest of the app.


# Update: For sprint 3: 

- Although this feature would have been an excellent addition to the application - due to time related issues - The auto generating map feature was removed from the final product. This was mainly due to issues translating the python code into swift, a number of the functionals that python supports are nearly impossible in swift. 

- The map maker is in integral piece of the puzzle when programming this game for production. To dynamically render the maps provides the user with the ability to continue on from one level to the next. The application will radomize an array of 1s and 0s as it does now, but instead would create the maps programmatically, and then load them into the core database. 

