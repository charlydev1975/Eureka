//
//  EUPhotosViewModel.swift
//  Eureka
//
//  Created by Carlos Caraccia on 9/23/22.
//

import Foundation
import CoreData

class EUPhotosViewModel:NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
    
    @Published var photos:[EUPhoto] = [EUPhoto]()
    
    private let fetchedResultsController:NSFetchedResultsController<EUPhoto>
    
    private var context:NSManagedObjectContext
    
    init(inMemoryModel:Bool) {
        
        let initialFetchRequest = NSFetchRequest<EUPhoto>(entityName: "EUPhoto")
        initialFetchRequest.sortDescriptors = []
        self.context = inMemoryModel ? PersistenceController(inMemory: true).container.viewContext :
                                       PersistenceController.shared.container.viewContext
        
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: initialFetchRequest,
                                                                   managedObjectContext: self.context,
                                                                   sectionNameKeyPath: nil,
                                                                   cacheName: nil)
        super.init()
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
            guard let euPhotos = fetchedResultsController.fetchedObjects else { return }
            self.photos = euPhotos
        } catch (let error) {
            print(error)
        }
    }
    
    // MARK: - Intents
    
    /// Function that saves a photo to the database. It works with the view context
    /// - Parameters:
    ///   - imageData: data representation of the image / photo that we want to save
    ///   - latitude: string representation of the latitude that came from the gps
    ///   - longitude: string representation of the longitude that came from the gps
    func addPhoto(withImageData imageData:Data, latitude:String, longitude:String) {
        let euPhoto = EUPhoto(context: self.context)
        euPhoto.imageData = imageData
        euPhoto.latitude = latitude
        euPhoto.longitude = longitude
        do {
            try context.save()
        } catch (let error) {
            print(error)
        }
    }
    
    // MARK: - FetchedResultsControllerDelegate
    
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
       // sync the array with the photos fetched.
        guard let euPhotos = controller.fetchedObjects as? [EUPhoto] else { return }
        self.photos = euPhotos
   }

}
