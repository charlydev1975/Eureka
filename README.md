#  Eureka

## Project

The project architecture selected was MVVM:

1. Model. We understand tha the model consists on the persistant layer of the project and the abbility to save to the store (Core Data - SQLite). We simply created a helper object to be displayed by SwiftUI since showing Core Data properties in the View Layer is not the best practice. The Persistence file contains a PersistentController class that we took (& modified) from Apple's default implementation. I contains a shared instance (that is not a Singleton since it can be overridden) to use with the in memory store (very usefull for testing purposes and previews).
2.  View Model. This Layer binds the Model and the View (with a ton of considerations). To support this in a fast way without making a mess, we made 2 of them.  One, to bind the persistent store and the View, and anotherone to bind CoreLocation and the View. The one to talk to the store contains an NSFetchedResultsController (which was originatelly desinged to talk to a UITableView/UICollectionView) that, with a minor tweak, was hooked to work with the with an ObervableObject/@ObservedObject. It takes an initial fetch and the when the context changes it performs that fetch again showing only the changes that were made to the store (really efficient). The VM also contains a boolean to initialize with an in memory store that is used on previews and testing. (EUPhotosViewModel is an awfull name, it should be called PhotosStoring or something meaningful, the name was given to show the architecture used, UserLocationManager is a better name) 
3. View. This is developped entirelly using and SwiftUI as a the main UIFramework, we only used UIKit to display the camera view.

### Testing

68.8 % of code coverage is a huge lie. We are only testing 1 of the View models, the one that could break and make a mess in the app. We should also test the errors that can happen when we would not load the store / when there was an error saving, etc. We are only printing messages. I don't know how to test the views in swiftui, I could test them with UIKit.
 
 ## My Code
 
 I don't like to add a ton of functionality to classes, they should have only 1 functionality (Single responsability principle)
 Also I like to modularize my code to test it. I don't like adding a lot of comments to my code, it should be self explanatory.
 
 ## Installing
 
 Download the project / fork it, and plug in your phone to install the project and use the camera.
 
## Notes

It is impossible to make a project like this in 48 hs having a job and other responsibilities. Currently there were a ton of fires in my job and it took me a lot of time from it. There are a lot of things more to test and improve (icons, remove the singleton from the UserLocationManager, error handling, uitests, ICONS and IMAGES!!!, etc). As a side note, the CI is failing due to the inhability to work with XCode 14.0 in a saved version. I took a CI from another project and it was working fine, but it does not supports the current project scheme. Using Fastlane will be an overkill for it, and besides I don't have the time to make it work. There's a software that Pinterest (I work as staff augmentation there) installs on my phone/mac preventing me to install any 3rd party developer software on it, so I could not test fully the camera.






