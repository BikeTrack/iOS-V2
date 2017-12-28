//
//  createBikeViewController.swift
//  Biketrack
//
//  Created by Valentin Wallet on 03/07/2017.
//  Copyright © 2017 Valentin Wallet. All rights reserved.
//

import UIKit

class createBikeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // UI
    @IBOutlet weak var bikeName: UITextField!
    @IBOutlet weak var bikeTracker: UITextField!
    @IBOutlet weak var bikeImg: UIImageView!
    @IBOutlet weak var addBikeLbl: UILabel!
    
    // Data
    let alertController = UIAlertController(title: "Erreur", message: "", preferredStyle: UIAlertControllerStyle.alert)
    let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    var ImgBuffer: Data = Data()
    var uploadingType: UploadImageType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        setUpActionSheet()
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
    }

    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setUpActionSheet() {
        let photoLibrary = UIAlertAction(title: "PhotoLibrary", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.open(type: UIImagePickerControllerSourceType.photoLibrary)
        })
        let camera = UIAlertAction(title: "Camera", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.open(type: UIImagePickerControllerSourceType.camera)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        
        optionMenu.addAction(photoLibrary)
        optionMenu.addAction(camera)
        optionMenu.addAction(cancelAction)
    }
    
    func fillBikeImg(with image: UIImage) {
        addBikeLbl.isHidden = true
        bikeImg.layer.cornerRadius = bikeImg.frame.size.height / 2
        bikeImg.layer.borderWidth = 0
        bikeImg.image = image
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            switch uploadingType {
            case .bike:
                fillBikeImg(with: image)
                PictureWorker.shared.uploadImage(with: .bike, image: image)
            case .bill:
                PictureWorker.shared.uploadImage(with: .bill, image: image)
            default:
                print("don't recongnize the good type")
            }
        } else{
            print("Something went wrong with the png formatting")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func open(type: UIImagePickerControllerSourceType) {
        print("bonsoir")
        if UIImagePickerController.isSourceTypeAvailable(type) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = type
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func addImageTapped(_ sender: Any) {
        uploadingType = .bike
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    @IBAction func uploadBillTapped(_ sender: Any) {
        uploadingType = .bill
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    @IBAction func addBikeBtn(_ sender: Any) {
        if (bikeName.text! == "") {
            alertController.message = "Le nom du vélo ne peut pas être vide"
            self.present(alertController, animated: true, completion: nil)
        }
        else if (bikeTracker.text! == "") {
            alertController.message = "Vous ne pouvez pas ajouter de vélo sans tracker"
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            _ = BiketrackAPI.createABike(name: bikeName.text!, brand: "")
                .subscribe({event in
                    switch event {
                    case .next(let response):
                        print("ah bon?")
                        print(response)
                        if let dict = response as? [String: Any] {
                            print(dict)
                            if let id = dict["bikeId"] as? String {
                                print(id)
                                if let bikeImage = PictureWorker.shared.getImageBuffer(with: .bike) {
                                    print("here on add l'image")
                                    self.addImage(bikeId: id, image: bikeImage)
                                }
                                if let billImage = PictureWorker.shared.getImageBuffer(with: .bill) {
                                    self.addBill(bikeId: id, image: billImage)
                                }
                                PictureWorker.shared.clean()
                            }
                        }
                      self.performSegue(withIdentifier: "toBikeListVC", sender: nil)
                    case .error(let error):
                        print("error fuck: \(error)")
                    default:
                        print("default createbike")
                    }
                }) 
        }
    }
    
    func addImage(bikeId: String, image: Data) {
        _ = BiketrackAPI.addBikePicture(bikeId: bikeId, pictureData: image).subscribe { event in
            switch event {
            case .next(let response):
                print(response)
            case .error(let error):
                print("error add image")
                print(error)
            default:
                print("default add bike picture")
            }
        }
    }
    
    func addBill(bikeId: String, image: Data) {
        _ = BiketrackAPI.addBillPicture(bikeId: bikeId, pictureData: image).subscribe { event in
            switch event {
            case .next(let response):
                print(response)
            case .error(let error):
                print(error)
            default:
                print("default add bike bill")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
