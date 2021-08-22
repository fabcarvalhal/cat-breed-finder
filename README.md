# Cat Breed Finder


### Description

Cat Breed Finder is an app created for the final project of the iOS Developer Nanodegree on Udacity.

PS: The classification model here has a low accuracy since my computer couldn't handle the processing of a bigger set of data and it may also make the repository too big

### Main features

- Tutorial showing the screens and how it works, only on first open.
- Load and display a list of cat breed from TheCatApi
- Filter the breeds by name by typing on the search bar on Breeds Tab
- Display Breed details on a dedicated screen wich shows the description, origin, photo (if possible) and a lot of characteristics of the breed on animated bars
- Add a breed to favorites from from the details screen by tapping the yellow star button
- See a list of your favorite breeds on the Favorites tab 
- Remove breed from favorite on the Favorite tab by swiping the row to the left
- Remove breed from favourte by tapping the filled star button on details screen
- And, finally, using a bit of vision and CoreML. Try to discover which cat breed is on a picture by tapping the big center button on tabbar. Its possible to select an image from camera (only on phisical device), camera roll or photo library 


### A small video showing how the app works : D

https://user-images.githubusercontent.com/40077209/130341110-631238ba-247f-46f8-b325-d5ba6c01b797.mp4

### Dependencies (using swift package manager)

- SDWebImage: load images, take care of lazyload images and the image cache
- Realm: to save the user favorites

### Requirements

- Xcode version: 12.4+
- Swift 5
- iOS: 14.4
