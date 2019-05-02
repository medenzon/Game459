## Infrastructure: xCode Simulator
# Date: 2/28/2019

# Status: Accepted
# Decision makers: Mike Enzo

#Contextual outline:
 - We have decided to use Swift and UIKit to build an iOS app. This will require us to build, run, test, and deploy our app through Xcode.

#Decision:
- Our choice of using the Xcode iOS Simulator along with testing on the iPhone is a direct necessity to our goal of building an IOS application. This is due to the fact that Docker and other VMs are not supported by iOS.

#consequence:
- We will be unable to use Docker or another VM. This will not allow use to containerize our environments.
- This will however, allow the team to work on a Swift application.

# Update for Final Sprint 
#5/2/2019

- A leaderboard was implemented using CoreData
- Star animation incorporates asynchronous process to detect the environmental data which is then translated and occurs while the avatar moves in accordance with the environmental data 
- Collision detection and the timer run in conjunction with the score of the user at the time which is then uploaded to the core data and displayed on a leaderboard to compare past results
- The timer adds another asynchronous process that runs during the game, and it conforms to our layered architecture of views -> managers & delegates -> controllers
