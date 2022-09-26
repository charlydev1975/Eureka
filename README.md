#  Eureka

## Project

The project architecture selected was MVVM:

1. Model. We understand tha the model consists on the persistant layer of the project and the abbility to save to the store (Core Data - SQLite). We simply created a helper object to be displayed by SwiftUI since showing Core Data properties in the View Layer is not the best practice. The Persistence file contains a PersistentController class that we took (& modified) from Apple's default implementation. I contains a shared instance (that is not a Singleton since it can be overridden) to use with the in memory store (very usefull for testing purposes and previews).
2.  View Model. This Layer binds the Model and the View (with a ton of considerations). To support this in a fast way without making a mess, we made 2 of them.  One, to bind the persistent store and the View, and anotherone to bind CoreLocation and the View. The one to talk to the store contains an NSFetchedResultsController (which was originatelly desinged to talk to a UITableView/UICollectionView) that, with a minor tweak, was hooked to work with the with an ObervableObject/@ObservedObject. It takes an initial fetch and the when the context changes it performs that fetch again showing only the changes that were made to the store (really efficient). The VM also contains a boolean to initialize with an in memory store that is used on previews and testing. (EUPhotosViewModel is an awfull name, it should be called PhotosStoring or something meaningful, the name was given to show the architecture used, UserLocationManager is a better name) 
3. View. This is developped entirelly using and SwiftUI as a the main UIFramework, we only used UIKit to display the camera view.

### Testing

68.8 % of code coverage is a bad guidance for testing. The tests should be written to test the correct behavior of the written code. We are only testing 1 of the View models. We should also test the errors that can happen when we would not load the store / when there was an error saving, etc. As said before time is an enemy so we cannot add all that functionality.

### Error handling
 We are only printing messages, which is really bad. We're not logging/showing messages, so the user has no idea if something goes wrong.
 
 ## My Code
 
 I don't like to add a ton of functionality to classes, they should have only 1 functionality (Single responsability principle). Testing is a must, besides ensuring the correct behavior of the written code, unit testing provides the benefit of having to make the code testable, this means breaking the code in pieces that can be tested. In that case if we have a bug we can tackle it in an isolated piece of code and solve it much faster. I like to test using AAA, it is the most straight forward and easy way to test. I don't like adding a lot of comments to my code, it should be self explanatory.
 
 ## Installing
 
 Download the project / fork it, and plug in your phone to install the project and use the camera.
 If you want to run the code it was done using XCode 14.0 and tested it in an iPhone 14 Pro simulator running iOS 16.0
 If you want you can use Robots and Pencils to have multiple versions of Xcode installed [Robots and Pencils](https://github.com/RobotsAndPencils/xcodes)
   
 
 ## Usage
 
 As the project requested it contains:
 - It contains a Launch / Splash screen (that can be improved drammatically)
 - The projects contain a button that will be active only when the gps module is working and a location is availlable, which will take the user to the camera
 - The picture will be taken and saved to CoreData and displayed in the main screen.
 - By clicking in the image the user can see it with more detail, with the respective image coordinates.
 
## Notes

It is impossible to make a project like this in 48 hs having a job and other responsibilities. Currently there were a ton of fires in my job and it took me a lot of time from it. There are a lot of things more to test and improve (icons, remove the singleton from the UserLocationManager, error handling, uitests, ICONS and IMAGES!!!, etc). 

### Project Notes
Currently when the tests run (and pass) we see a warning in the console related to core data. This is because we are creating the store multiple times. If you want to get more insight about the error this [link](https://stackoverflow.com/questions/51851485/multiple-nsentitydescriptions-claim-nsmanagedobject-subclass) provides you more data on it.
As a side note, the CI is failing due to the inhability to work with XCode 14.0 in a saved version. I took a CI from another project and it was working fine, but it does not supports the current project scheme. Using Fastlane will be an overkill for it, and besides I don't have the time to make it work. There's a software that Pinterest (I work as staff augmentation there) installs on my phone/mac preventing me to install any 3rd party developer software on it, so I could not test fully the camera.
