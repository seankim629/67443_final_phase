//
//  ContentView.swift
//  Cheers_v1
//
//  Created by Sung Tae Kim on 10/28/21.
//
import SwiftUI
import UIKit
import MLKitBarcodeScanning
import MLKitVision
struct ScanView: View {
    
    @State var sourceType: UIImagePickerController.SourceType = .camera
    @Binding var selectedImage: UIImage?
    @State var isImagePickerDisplay: Bool = true
    @Binding var barcodeValue: String?
    @State var back: Bool = false
    @Binding var selectedTab: Tab
    
    var body: some View {
        if isImagePickerDisplay {
            ImagePickerView(image: self.$selectedImage, imagePickerDisplay: self.$isImagePickerDisplay,back: self.$back, barcodeValue: self.$barcodeValue, selectedTab: self.$selectedTab, sourceType: self.sourceType)

        } else if back {
            ContentView(selectedTab: self.$selectedTab, selectedImage: self.$selectedImage, barcodeValue: self.$barcodeValue)
        }
        else {
//        NavigationView {

            VStack {
                
                if selectedImage != nil {
                    Image(uiImage: selectedImage!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Rectangle())
                }
            
                
//                Button("Camera") {
////                    CameraViewController()
//                    self.sourceType = .camera
//                    self.isImagePickerDisplay.toggle()
//                }.padding()
//                
//                Button("photo") {
//                    self.sourceType = .photoLibrary
//                    self.isImagePickerDisplay.toggle()
//                }.padding()
//
                HStack {
                    
                NavigationLink(
                    destination: ContentView(selectedTab: self.$selectedTab, selectedImage: self.$selectedImage, barcodeValue: self.$barcodeValue).navigationBarHidden(true)) {
                        Text("Cancel").padding(30)
                    }.simultaneousGesture(TapGesture().onEnded{
                        self.selectedTab = .home
                    })
//                Button("Cancel") {
//
//                }.padding(30)
                    
                    NavigationLink(destination: ContentView(selectedTab: self.$selectedTab, selectedImage: self.$selectedImage, barcodeValue: self.$barcodeValue)) {
                    Text("Detect").padding(30)
                    }.simultaneousGesture(TapGesture().onEnded{
                        self.selectedTab = .result
                        print(self.barcodeValue!)
                    })
//                    Button("Detect") {
//                        self.selectedTab = .result
//                    }.padding(30)
                    
                Button("Retake") {
                    self.isImagePickerDisplay = true
                }.padding(30)
                
                
                
                }
            }
            .navigationTitle("Scan").navigationBarTitleDisplayMode(.inline)
//            .sheet(isPresented: self.$isImagePickerDisplay) {
//                ImagePickerView(image: self.$selectedImage, imagePickerDisplay: self.$isImagePickerDisplay, back: self.$back, barcodeValue: self.$barcodeValue, sourceType: self.sourceType)
//            }
        
        }
                
        }
//        }
    
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

