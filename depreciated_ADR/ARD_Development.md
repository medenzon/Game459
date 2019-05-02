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
