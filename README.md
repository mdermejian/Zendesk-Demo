# Zendesk-Demo

This is a small project demonstrating Zendesk's Tickets API.


Please open the project using ZendeskTest.xcworkspace.


The project was developed using 8.1 and Swift 3

Project tested on iPhone 6 running iOS 9.3.5 and iPhone 5S running iOS 10.1.1


There are a few aspects that are not (properly) currently handled. That includes:

Proper caching/persistence mechanism

Network connectivity listener and automatic retry of failed network calls

Proper error handling 


The UI was also kept to a minimum.

For larger projects, with the possibility of a suite of applications sharing common code, I would group functionalities into reusable independent frameworks.

For instance, networking and the core layer would be moved into separate cocoa touch frameworks.


This is by no means a complete solution but it reflects the patterns that I adopt and should provide an idea regarding my approach and my decision making.
