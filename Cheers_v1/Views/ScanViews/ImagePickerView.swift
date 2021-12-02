//
//  ImagePickerView.swift
//  Cheers_v1
//
//  Created by Sung Tae Kim on 11/1/21.
//
import UIKit
import SwiftUI
import UIKit
import MLKitBarcodeScanning
import MLKitVision

struct ImagePickerView: UIViewControllerRepresentable {
    
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var isPresented
    @Binding var imagePickerDisplay : Bool
    @Binding var back : Bool
    @Binding var barcodeValue : String?
    @Binding var selectedTab: Tab
    var sourceType: UIImagePickerController.SourceType
        
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = self.sourceType
        imagePicker.delegate = context.coordinator // confirming the delegate
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {

    }

    // Connecting the Coordinator class with this struct
    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self)
    }
}



class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: ImagePickerView
    
    init(picker: ImagePickerView) {
        self.picker = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        self.picker.image = image
        let format = BarcodeFormat.all
        let barcodeOptions = BarcodeScannerOptions(formats: format)
        // [END config_barcode]

        // Create a barcode scanner.
        // [START init_barcode]
        let barcodeScanner = BarcodeScanner.barcodeScanner(options: barcodeOptions)
        // [END init_barcode]

        // Initialize a `VisionImage` object with the given `UIImage`.
        let visionImage = VisionImage(image: image)
        visionImage.orientation = image.imageOrientation
      


        // [START detect_barcodes]
        barcodeScanner.process(visionImage) { features, error in
          guard error == nil, let features = features, !features.isEmpty else {
            // [START_EXCLUDE]
  //                print("No results returned.")
              self.picker.barcodeValue = "No barcode detected."
              return
          }



            for feature in features {

                self.picker.barcodeValue = feature.rawValue
            }
       

        }
        self.picker.imagePickerDisplay = false
        self.picker.isPresented.wrappedValue.dismiss()
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        self.picker.imagePickerDisplay = false
        self.picker.selectedTab = .home
        self.picker.image = nil
      }

}
