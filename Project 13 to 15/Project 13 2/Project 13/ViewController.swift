//
//  ViewController.swift
//  Project 13
//
//  Created by user197801 on 6/6/21.
//
import CoreImage
import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet var intensity2: UISlider!
    @IBOutlet var intensity1: UISlider!
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var buttonFilters2: UIButton!
    @IBOutlet var buttonFilters1: UIButton!
    var originalImage: UIImage!
    var processedImage: UIImage!
    var context: CIContext!
    var filter1: CIFilter!
    var filter2: CIFilter!
    
    let filters = ["Bump Distortion": "CIBumpDistortion" , "Gaussian Blur": "CIGaussianBlur", "Pixellate": "CIPixellate","Sepia Tone": "CISepiaTone", "Twirl Distortion": "CITwirlDistortion", "Unsharp Mask": "CIUnsharpMask", "Vignette": "CIVignette"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Instagram Filter"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importPicture))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(resetImage))
        
//        filter1 = CIFilter(name: "CISepiaTone")
        
    }
    @objc func resetImage() {
        processedImage = originalImage
        imageView.image = processedImage
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
        originalImage = image
        processedImage = image
        title = "Select Filter and Apply"
        imageView.image = image
        UIView.animate(withDuration: 1.5, delay: 0, options: [], animations: {
            self.imageView.alpha = 1
        })
//        let beginImage = CIImage(image: processedImage)
//        filter1.setValue(beginImage, forKey: kCIInputImageKey)
//        applyProcessing(withTag: 1)
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
    
    @IBAction func changeFilter1(_ sender: UIButton) {
        let ac = UIAlertController(title: "Filter Change", message: nil, preferredStyle: .actionSheet)
        
        for key in filters.keys {
            ac.addAction(UIAlertAction(title: key, style: .default, handler: setFilter1))
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        if let popoverController = ac.popoverPresentationController {
            popoverController.sourceView = sender
            popoverController.sourceRect = sender.bounds
        }
        present(ac, animated: true)
    }
    
    func setFilter1(_ action: UIAlertAction) {
        
        
        guard processedImage != nil else {return}
        guard let actionTitle = action.title else {return}
//        title = actionTitle
        filter1 = CIFilter(name: filters[actionTitle]!)
        
        let beginImage = CIImage(image: processedImage)
        filter1.setValue(beginImage, forKey: kCIInputImageKey)
        buttonFilters1.setTitle(actionTitle, for: .normal)
        
        applyProcessing(withTag: 1)
    }
    
    @IBAction func changeFilter2(_ sender: UIButton) {
        let ac = UIAlertController(title: "Filter Change", message: nil, preferredStyle: .actionSheet)
        
        for key in filters.keys {
            ac.addAction(UIAlertAction(title: key, style: .default, handler: setFilter2))
        }
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        if let popoverController = ac.popoverPresentationController {
            popoverController.sourceView = sender
            popoverController.sourceRect = sender.bounds
        }
        present(ac, animated: true)
    }
    func setFilter2(_ action: UIAlertAction) {
        
        guard processedImage != nil else {return}
        guard let actionTitle = action.title else {return}

        filter2 = CIFilter(name: filters[actionTitle]!)
        
        let beginImage = CIImage(image: processedImage)
        filter2.setValue(beginImage, forKey: kCIInputImageKey)
        buttonFilters2.setTitle(actionTitle, for: .normal)
        
        applyProcessing(withTag: 2)
    }
    
    @IBAction func intensityChange2(_ sender: UISlider) {
        print("change 2")
        guard let _ = processedImage else {
            return
        }
        guard let _ = filter2 else {
            return
        }
        let beginImage = CIImage(image: processedImage)
        filter2.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing(withTag: sender.tag)
    }
    @IBAction func intensityChange1(_ sender: UISlider) {
        print("change 1")
        guard let _ = processedImage else {
            return
        }
        guard let _ = filter1 else {
            return
        }
        let beginImage = CIImage(image: processedImage)
        filter1.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing(withTag: sender.tag)
    }
    
    func applyProcessing(withTag tag: Int) {
        context = CIContext()
        print("Start apply")
        var filterToProcessing: CIFilter!
        var intensity : UISlider!
        print(tag)
        if tag == 1 {
            filterToProcessing = filter1
            intensity = intensity1
        }
        if tag == 2 {
            filterToProcessing = filter2
            intensity = intensity2
        }
        let inputKeys = filterToProcessing.inputKeys
        print(inputKeys)
        if inputKeys.contains(kCIInputIntensityKey) {
            filterToProcessing.setValue(intensity.value*0.5, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            filterToProcessing.setValue(intensity.value * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            filterToProcessing.setValue(intensity.value * 20, forKey: kCIInputScaleKey)
        }
        if inputKeys.contains(kCIInputCenterKey) {
            filterToProcessing.setValue(CIVector(x: processedImage.size.width/2, y: processedImage.size.height/2), forKey: kCIInputCenterKey)
        }
        guard let outputImage = filterToProcessing.outputImage else {return}
        
        
        
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            processedImage = UIImage(cgImage: cgImage)
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

