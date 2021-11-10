//
//  DetailsView.swift
//  Cheers_v1
//
//  Created by Sung Tae Kim on 11/5/21.
//

import SwiftUI
import UIKit
import MLKitBarcodeScanning
import MLKitVision

struct DetailsView: View {
    @Binding var selectedImage: UIImage?
    @Binding var barcodeValue: String?
    @Binding var selectedTab: Tab
    

    
    var body: some View {
//        detectBarcode()
        if barcodeValue == nil {
            Text("Barcode Not Recognized, Try again")
            
        }
        
        if barcodeValue != nil{
            VStack{
                HStack{
                    Text("Barcode Value: ")
                    Text(self.barcodeValue!)
                }
//            Image(uiImage: selectedImage!)
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .clipShape(Rectangle())

            }
        }
        
            
    }
    
    
    func detectBarcode() {
      guard let image = selectedImage else { return }


      // Define the options for a barcode detector.
      // [START config_barcode]
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
            return
        }



          for feature in features {

            
              self.barcodeValue = feature.rawValue
          }
     
        
      }
    }
}

