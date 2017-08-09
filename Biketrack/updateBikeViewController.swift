//
//  updateBikeViewController.swift
//  Biketrack
//
//  Created by Valentin Wallet on 03/07/2017.
//  Copyright © 2017 Valentin Wallet. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class updateBikeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var updateBtn: UIButton!
    @IBOutlet weak var bikeName: UITextField!
    @IBOutlet weak var bikeBrand: UITextField!
    @IBOutlet weak var bikePicture: UIImageView!
    private var _bike: Bike!
    var imageData: String = ""
    
    var bike: Bike {
        get {
            return _bike
        } set {
            _bike = newValue
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            bikePicture.image = image
            let imageCompressed: Data = UIImageJPEGRepresentation(image, 0.1)!
            let strBase64: String = imageCompressed.base64EncodedString(options: .lineLength64Characters)
            imageData = strBase64
        } else{
            print("Something went wrong")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addPictureBikeBtn(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
        bikeName.text = bike.name
        bikeBrand.text = bike.brand
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupRx() {
        _ = updateBtn.rx.tap
            .flatMap({
                return BiketrackAPI.updateBike(bikeId: self.bike.id, name: self.bikeName.text!, brand: self.bikeBrand.text!, image: self.imageData)})
            .subscribe({ event in
                switch event {
                case .next(let response):
                    print(response)
                    if let dict = response as? Dictionary<String, AnyObject> {
                        print(response)
                        if let bike = dict["bike"] as? Dictionary<String, AnyObject> {
                            self.bike.name = bike["name"] as! String
                        }
                    }
                    self.performSegue(withIdentifier: "toOneBikeVC", sender: nil)
                default:
                    print("default update bike")
                }
            })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? OneBikeViewController {
            destination.bike = bike
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
