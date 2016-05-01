
## Introduction

This was my first "real" app that I created that could run on the iPhone, I had played around in Interface Builder before and using static cells and lables made a couple of static demo applications. this was the first time I had written `Objective-C` code. taking advatange of demo projects from the WWDC keynotes and using a few books I was able to put together bits of things and created what you see here. the app is mostly an `iOS 7` demo most of the content using newley introduced frameworks. For the art assests I used [Sketch.app](http://www.sketchapp.com), the database is a `.PLIST` file that created by an `AppleScript` that scraped the Lush Website for images and text content, then stored it in Arrays and Dictionaries. 

> "Standing on the shoulders of giants"

I used so many great resources while learning, some of the ones I can recall are `CRMotionView`, `ParallaxScrollingFramework`, `SLColorArt`, `Colours`.  Take a look at the files in the project for more information, also check out my stars.


**Books, Sites and StackOverflow answers provided by the greats:**

 - [Ray Wenderlich](https://www.raywenderlich.com)
 - [Ole Begemann](http://oleb.net)
 - [Erica Sadun](http://ericasadun.com)
 - [Nick Lockwood](https://github.com/nicklockwood)
 - [NS Hipster](http://nshipster.com)
 - [Ash Furrow](https://ashfurrow.com)
 
 
## App Statement
 
For new employees to help learn about the Products and Ingredients Lush uses and makes.

## Ingredient View

![Alt Text](https://github.com/jmade/jmade.github.io/blob/master/tableView.gif?raw=true)

- The App starts out with a basic `UITableView` that populated with all the different ingredients. 

- When the table view cell is selected a `UICollectionView` springs up and bounces into place utilizing the shiny new `UIViewControllerAnimatedTransitioning` protcols.

- Fixed width cell sizes so it appears as a tableview.

- Dynamic height and text size supported.

- CollectionView header with scroll animation that fades in and out blur covered image with a scrolling view that pans in response to tilt of your device. 

- Scrolling the cells mimics the effect of the messages application using springs and utilizing a `UIDynamicAnimator` object's ingtegration with a `UICollectionViewLayout` object.

- Tapping on the Products button will start an animated switch transition.


## Products View

![Alt Text](https://github.com/jmade/jmade.github.io/blob/master/transitions.gif?raw=true)

- Swinging in is the Products View Controller, using `UIDynamicAnimator` the products bounce in at random that you can tap to make snap into place, making it a fun game-like way to get a user to interact with the products.

- Swipe back to go back to the information view which also features a speech bubble at the top left of the navigation bar to have the name of the Ingedient spoken for you using `AVSpeechSynthesizer`.

- A user can also perform a pinch to start an gesture driven interactive animated trasition.

## Product View

**Disclaimer** this was only created for one product, I created all the artwork assest and design concepts and Im not a "designer" so I only made one since i was just mainly trying to learn about coding and less about how hard designing is.

![Alt Text](https://github.com/jmade/jmade.github.io/blob/master/flying-fox.gif?raw=true)

- This view was mainly inspired by the scrolling start animations you see in common apps now. 

- The entire interaction is driven around the users scrolling, using a paged view snap so it could be flicked instead. this taught me how powerful it is to be able as a user to comepletly control the experience.

- Flicking back at anytime bring back up the products view still in sight which i think allows for the user to also feel comfortable about know where they came from and how they can get back.
