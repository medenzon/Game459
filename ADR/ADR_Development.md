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
- The application incorporates asynchronous processes to detect the environmental data which is then translated. All of this occurs while the avatar is being moved based on the accelerometer data which is provided by the harware within the phone 
- Swift is a compiled language and when the application is compiled it's spun up inside Apple's proprietary containerization software 
- The timer instance needs to access the time library and change the time asynchronously, presenting the user with a countdown timer from one minute
- Collision detection and the timer run in conjunction with the score of the user at the time which is then uploaded to the core data and displayed on a leaderboard to compare past results
- The timer adds another asynchronous process that runs during the game, and it conforms to our layered architecture of views -> managers & delegates -> controllers
- Please look at the github commits on both forks of the application on github to see communal participation in the development of this application.
