# zemoga
IDE:
Zemoga.xcworkspace was created using xcode 10.1

Proposed Architecture:
this project have a basic MVC architecture as a base, but many "helpers" try to organize each operation using on models, views or controlles; in group "Others" I always include animation files, fetch files to do models operations, to define constants, do extensions and others, always to separate the logic of each functionality, easily to understand and maintain.
You should created storyboards for more functionalityes, or section in the apps, for example if we include a chat between users, we should do that in anotther sttoryboard, to reduce lack in Xcode, and help to others developer to work at the same time in our app without repository conflicts, thats the reason why, I used Xib it is easily to maintain.
Third-pary libraries:
I always recommend to not use too much libraries, because the app size increase, and the most of times you dont need the 100% of the librarie functionalities, to select the perfect one librarie, you need to know if the librarie have a regular maintain, and among reviews, to take the risk to delegate a responsability in your code.
There are two of my top libraries
AFNetworking:
Used to manage all request.
SwiftLint:
Used to remember to always create clean code.

This app was created without too much time, in code you can found TODO comments to know the next steps, just one file was tested, but I recoment to test al least 70% of the code, The coverage doesn't arrive to this percent because time limits.

TODO in Design:

The icons, colors and sizes of the app should be change according design specifications, I just used regular icons for all sizes, but its necessary to create 1x, 2x and 3x sizes, actually I know to create it using scketch but I didnt create it because time limits.
