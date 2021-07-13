//
//  ViewController.swift
//  Project 13
//
//  Created by user197801 on 6/6/21.
//
import CoreImage
import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet var intensity: UISlider!
    @IBOutlet var imageView: UIImageView!
    
    var currentImage: UIImage!
    var context: CIContext!
    var currentFilter: CIFilter!
    
    let filters = ["Bump Distortion": "CIBumpDistortion" , "Gaussian Blur": "CIGaussianBlur", "Pixellate": "CIPixellate","Sepia Tone": "CISepiaTone", "Twirl Distortion": "CITwirlDistortion", "Unsharp Mask": "CIUnsharpMask", "Vignette": "CIVignette"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Instagram Filter"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importPicture))
        
        context = CIContext()
        currentFilter = CIFilter(name: "CISepiaTone")
        
    }
    
    @objc func importPicture() {
        imageView.alpha = 0
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {return}
        dismiss(animated: true)
        currentImage = image
        UIView.animate(withDuration: 1.5, delay: 0, options: [], animations: {
            self.imageView.alpha = 1
        })
        title = "Sepia Tone"
//        imageView.image = image
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    @IBAction func save(_ sender: Any) {
        if let image = imageView.image {
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(statusImageSave(_:didFinishSavingWithError:contextInfo:)),nil)
        } else {
            let ac = UIAlertController(title: "Save error!", message: "Please select an image first!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac,animated: true)
        }
    }
    
    @IBAction func changeFilter(_ sender: UIButton) {
        let ac = UIAlertController(title: "Filter Change", message: nil, preferredStyle: .actionSheet)
        
        for key in filters.keys {
            ac.addAction(UIAlertAction(title: key, style: .default, handler: setFilter))
        }
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        if let popoverController = ac.popoverPresentationController {
            popoverController.sourceView = sender
            popoverController.sourceRect = sender.bounds
        }
        present(ac, animated: true)
    }
    
    func setFilter(action: UIAlertAction) {
        guard currentImage != nil else {return}
        guard let actionTitle = action.title else {return}
        title = actionTitle
        currentFilter = CIFilter(name: filters[actionTitle]!)
        
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        
        applyProcessing()
    }
    
    @IBAction func intensityChange(_ sender: Any) {
        applyProcessing()
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        print(inputKeys)
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(intensity.value, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(intensity.value * 100, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(intensity.value * 10, forKey: kCIInputScaleKey)
        }
        if inputKeys.contains(kCIInputCenterKey) {
            currentFilter.setValue(CIVector(x: currentImage.size.width/2, y: currentImage.size.height/2), forKey: kCIInputCenterKey)
        }
        guard let outputImage = currentFilter.outputImage else {return}
        
        
        
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            let processedImage = UIImage(cgImage: cgImage)
            imageView.image = processedImage
        }
    }
    
    @objc func statusImageSave(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac,animated: true)
            
            
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your alter image has been saved to your photos", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
//    //this function is pretty long and do nothing :))
//    func presentString(_ input: String) -> String {
//        var position = 0
//
//        let newInput = input.replacingOccurrences(of: "CI", with: "")
//
//        var chars = Array(newInput)
//        for (index,character) in newInput.enumerated() {
//            chars[index] = character
//            if character.isUppercase {position = index}
//        }
//        if position != 0 { chars.insert(" ", at: position)}
//
//        return String(chars)
//    }
    
    
}

