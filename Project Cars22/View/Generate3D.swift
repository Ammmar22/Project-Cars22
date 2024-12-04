//
//  Generate3D.swift
//  Project Cars22
//
//  Created by Abderrahmen on 25/11/2024.
//

import SwiftUI

struct Generate3D: View {
    @State private var selectedImage: UIImage?
       @State private var modelPath: String?
    @State private var showphotoPicker: Bool = false
    @State private var isModelDisplayed: Bool = false // Track if the model should be displayed



       var body: some View {
           VStack {
             

               Button("Select Photo") {
                   showphotoPicker = true
               }
               .foregroundColor(.blue) // Ensure the color makes the icon visible

               .sheet(isPresented: $showphotoPicker) {
                   PhotoPicker(selectedImage: $selectedImage)
               }

               Button("Generate 3D Model") {
                   if let image = selectedImage {
                       let imagePath = saveImageToTempDirectory(image: image)
                       let outputPath = "/Users/abderrahmen/Downloads/TripoSR-main/output/0/"

                       uploadImage(image: image) { success in
                           if (success != nil) {
                               self.modelPath = outputPath + "/mesh.obj" // Update with the correct file path
                               print("i am here ")
                               self.isModelDisplayed = true // Trigger display of the model
                           }
                       }
                   }
               }               .foregroundColor(.blue) // Ensure the color makes the icon visible
               if isModelDisplayed, let modelPath = modelPath {
                   Model3DView(modelName: "mesh")
                                 .frame(height: 400) // Set a frame for the 3D model display
                         }
               

           }
       }
    
    
    
    
    func saveImageToTempDirectory(image: UIImage) -> String {
          let tempDir = FileManager.default.temporaryDirectory
          let imagePath = tempDir.appendingPathComponent("input.png")
          if let data = image.pngData() {
              try? data.write(to: imagePath)
          }
          return imagePath.path
      }
}

#Preview {
    Generate3D()
}
