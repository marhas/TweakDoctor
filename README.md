# Tweak Doctor #

Makes adding new A/B test tweaks to Mixpanel a breeze!

This is a task that can be very tedious, especially if you are a large organization and/or have many tweaks;
 - Only one person at a time can connect to Mixpanel's A/B Test Designer so if you have many developers in your organization it might be hard to connect.
 - The recommendation (from Mixpanel) is to build a special version of the app with all tweaks but the one you want in your current A/B test commented out before you connect to the A/B Test Designer. This takes quite some extra time, especially if you have both a staging and a production version of the app that will each have to be built and connected to Mixpanel.

 This tool will let you add a new tweak without acutally involving your app at all and supports two environments ("projects" as they are called in Mixpanel) which you can typically use for your stage and production configurations. If the A/B Test Designer is currently connected to someone else the connection will be retried (up to 40 times) before giving up.

# Install & Run

Either pull a pre-built binary from the releases page or download the source and build it yourself.

You need to add the API token for your stage and/or production environment before you can connect to the Mixpanel A/B test designer.  

## Building:

You need Xcode and CocoaPods to build the project.
Start by running ```pod install```in the project root.
This will generate tweakdoctor.xcworkspace which you should open in Xcode and then build & run from there.

## Final notes
I've talked to Mixpanel about the shortcomings that this tool aims to solve. They know about the issues and are working to have them fixed. Hopefully this tool will be obsolete soon but until then it saves me a ton of time and I hope it can also help someone else.
