//
//  PictureWorker.swift
//  Biketrack
//
//  Created by Valentin Wallet on 21/12/2017.
//  Copyright © 2017 Valentin Wallet. All rights reserved.
//

import Foundation

enum UploadImageType {
    case bike
    case user
    case bill
}

class PictureWorker : NSObject {
    // Singleton
    static let shared: PictureWorker = PictureWorker()
    
    // Data
    var buffers: [UploadImageType: Data] = [UploadImageType: Data]()
    
    func uploadImage(with type: UploadImageType, image: UIImage) {
        if let buffer = UIImageJPEGRepresentation(image, 0.1) {
            buffers[type] = buffer
        }
    }
    
    func clean() {
        self.buffers = [UploadImageType: Data]()
    }
    
    func getImageBuffer(with type: UploadImageType) -> Data? {
        return buffers[type]
    }
}
