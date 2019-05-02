## Development
# Date: 2/28/2019

# Status: Accepted
# Decision makers: Mike Enzo, Will Hundahl, Alexander Schlesinger

#Contextual outline:
 - Our Team is Making an iOS mobile game.

#Decision:
- Swift: The choice of swift is based on several factors
  - Readability: Swift has a cleanly written syntax. The key advantage, is that as a team we can quickly review and understand the work done by other team members. In addition, two team members are relatively new to swift. The easy to read syntax will help them pick up on how the language works.

- Dynamic Libraries: Swift allows for Dynamic Libraries(executable chunks of code that can be linked to the app) cutting down on development time. Less code to perform tasks.

- Apple UIKit: Provides a robust SDK with pre-built objects optimized for iOS devices. The UI kit will allow us to develop and deploy rich, interactive features quickly.

- CoreData: This framework will allow us to manage the model layer of our app. It is developed by apple (along with our other tools) making it the easiest to integrate into our system.
# Final product details
#5/2/2019

- The final application provides the user with the ability to interact with the user's Iphone using physical movement that is translated into the movement of the avatar on the viewport

- The application in it's entirety is based upon the architectural decisions that are employed by Apple when creating the Swift development interface. Because of this we are forced to follow strict guidelines in terms of decision making when loading the initial data, computing the data, and presenting it to the user. 

- The final product needs to integrate with the Apple Game Store in order to create a real time user leaderboard calling an API endpoint to gather the list of users and their scores 

- The final product also needs to submit user data using the user's apple ID to a server that stores the data on the highscores of the users. This information would then need to be sorted and ordered before being presented on the frontend in a table. 
