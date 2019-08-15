# City List - mobile assignment (iOS)
last rev. 2018-08-10

[![Build Status](https://travis-ci.org/riza-milani/CityList-MVP.svg?branch=master)](https://travis-ci.org/riza-milani/CityList-MVP)

Following subjects used in this project:
* Xcode 10.2.1
* Swift 4.2 (5)
* iOS 10+
* Simplified VIPER architecture (removed data manager and interactors for simplicity) - semilar to MVP/MVC.


## Technical declaration:
* When user runs application, loading and converting json file begins in '.userInitiated' thread. It's unblocking and faster than '.background'. During loading json file application is responsive.
* For implementing given wire frame, master-detail controller is chosen.
* During json loading, search bar is inactive and progress indicator rotating until data prepared.
* In the information screen (about info), I assume the goal of this part is reusing this module with less modification. So, I tried to avoid refactoring or modification.
* It took about ~3 days to finish this assignment.
* One of the challenging parts was ui test, because loading data was heavy. So, I used 60 secs timer to check if data loaded or not.
* The other challenging part was search result order when user typing the deleting fast. I used a string to handle it.
* Because UI was not complex, I didn't use any interface builder artifacts (e.g. xib, storyboard).
* I usually implement base protocols or classes to implement general and shared functions, But in this particular example I didn't.

## Search Algorithm (Filtering)
* I used custom dictionary, that the key is the letter of the city. and the value is list of the cities which start with key letter.
* When user start typing, first letter of the search string will be checked in the dictionary and then in a for loop all the cities compared to the whole of the search string.
* This algorithm is not the fasted solution but in practice UX and responsiveness was fluent. (In my opinion :) )
* All of the sorts and filters functions are swift's core functions. I didn't implement any specific.
* All of the time consumption functions take place in other threads (background).

## Alternative Algorithm:
* It could be '.barrier' concurrent threads and using chunk data (dividing list into smaller lists), but handling the result was complex. So, there were no benefits to use this way.
* Other algorithm was big string and regex. It didn't go further than concept.


