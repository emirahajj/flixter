# Flix

Flix is an app that allows users to browse movies from the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

## Flix Part 2

### User Stories

#### REQUIRED (10pts)
- [x] (5pts) User can tap a cell to see more details about a particular movie.
- [x] (5pts) User can tap a tab bar button to view a grid layout of Movie Posters using a CollectionView.

#### BONUS
- [x] (2pts) User can tap a poster in the collection view to see a detail screen of that movie.
- [ ] (2pts) In the detail view, when the user taps the poster, a new screen is presented modally where they can view the trailer.

Additional bonuses: Implemented a scroll view on the poster detail view and embedded a YouTube video of the trailer right in the details view. 

### App Walkthrough GIF

<img src="https://i.imgur.com/ESn1icX.gif"/>
<img src="https://i.imgur.com/OiP0Jtp.gif"/>

### Notes
Describe any challenges encountered while building the app.
Not too many difficulties with this part. Just further familiarizing myself with constraints. I got my views to all look the same way across devices. 

---

## Flix Part 1

### User Stories

#### REQUIRED (10pts)
- [x] (2pts) User sees an app icon on the home screen and a styled launch screen.
- [x] (5pts) User can view and scroll through a list of movies now playing in theaters.
- [x] (3pts) User can view the movie poster image for each movie.

#### BONUS
- [x] (2pt) User can view the app on various device sizes and orientations.
- [ ] (1pt) Run your app on a real device.

### App Walkthrough GIF
App as run on an iPhone 6, iPhone XR, and iPhone XR in landscape mode.

<img src ='https://i.imgur.com/7NQ1kEQ.gif'/>
<img src ='https://i.imgur.com/HLNBSTO.gif'/>
<img src ='https://i.imgur.com/WZQ1dJc.gif'/>
### Notes
Describe any challenges encountered while building the app.

The most challenging part was figuring out the constraints. I had to do some twaeking beyond what the tutorials outlined, but I eventually got it!
Because I'm on Xcode 10.1, I had to downgrade the version of the AlamoFireImage pod for it to work on my machine, because otherwise, the import statement would give me a compliation error.
