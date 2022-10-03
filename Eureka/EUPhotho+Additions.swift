//
//  EUPhotho+Additions.swift
//  Eureka
//
//  Created by Carlos Caraccia on 10/3/22.
//

import Foundation
import UIKit


/*  This extension should go in the view model and we should treat it as a helper property of the view model.
    We could keep the other approach and have the other object in the view model. */

extension EUPhoto {
    
    var photoImage:UIImage {
        get { if let data = self.imageData {
                // either we display the image or if the data was corrupted show the data corrupted file
                return UIImage(data: data) ?? UIImage(imageLiteralResourceName: "corrupted-file")
            } else {
                // if there is not data at all, then we show a now image icon
                return UIImage(imageLiteralResourceName: "no-image-icon")
            }
        }
    }
}
