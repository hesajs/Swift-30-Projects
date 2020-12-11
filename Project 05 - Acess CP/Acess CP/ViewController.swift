//
//  ViewController.swift
//  Acess CP
//
//  Created by SaJesh Shrestha on 12/3/20.
//

import UIKit

class ViewController: UIViewController {

    //MARK:- IBOutlets
    @IBOutlet weak var imageView: UIImageView!

    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //MARK:- IBActions
    @IBAction func addButtonTapped(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        
        let alertVC = UIAlertController(title: "Select photos from", message: "", preferredStyle: .actionSheet)
        
        let photoLibraryAction = UIAlertAction(title: "From Photo Library", style: .default) { (action) in
            vc.sourceType = .photoLibrary
            self.present(vc, animated: true, completion: nil)
        }
        let cameraAction = UIAlertAction(title: "Take from the camera", style: .default) { (action) in
            vc.sourceType = .camera
            self.present(vc, animated: true, completion: nil)
        }

        alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertVC.addAction(photoLibraryAction)
        alertVC.addAction(cameraAction)
        
        alertVC.popoverPresentationController?.sourceView = (sender as! UIButton)
        alertVC.popoverPresentationController?.sourceRect = (sender as! UIButton).bounds
        present(alertVC, animated: true, completion: nil)
    }
}


//MARK:- UIImagePickerController Delegate
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.editedImage] as? UIImage {
            imageView.image = image
        }
        picker.dismiss(animated: true, completion: nil)

    }
}
