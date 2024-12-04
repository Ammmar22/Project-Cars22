//
//  carDetails.swift
//  Project Cars22
//
//  Created by Abderrahmen on 27/11/2024.
//

import SwiftUI

struct carDetails: View {
    @State private var selectedImage: UIImage? = nil
       @State private var isImagePickerPresented: Bool = false
       @State private var apiResponse: String = "No response yet"
       @State private var isLoading: Bool = false
    @State private var googleDriveURL: String? = nil

    var body: some View {
        VStack(spacing: 20) {
                   // Display the selected image or a placeholder
                   if let image = selectedImage {
                       Image(uiImage: image)
                           .resizable()
                           .scaledToFit()
                           .frame(height: 200)
                           .cornerRadius(10)
                   } else {
                       Rectangle()
                           .fill(Color.gray.opacity(0.3))
                           .frame(height: 200)
                           .cornerRadius(10)
                           .overlay(Text("Select an Image").foregroundColor(.gray))
                   }
                   
                   // Button to open the image picker
                   Button(action: {
                       isImagePickerPresented = true
                   }) {
                       Text("Choose Image")
                           .font(.headline)
                           .padding()
                           .frame(maxWidth: .infinity)
                           .background(Color.blue)
                           .foregroundColor(.white)
                           .cornerRadius(10)
                   }
                   
                   // Button to upload and call the API
                   Button(action: {
                       if let image = selectedImage {
                           uploadImageToGoogleDrive(image: image)
                         

                       }
                   }) {
                       if isLoading {
                           ProgressView()
                               .frame(maxWidth: .infinity)
                               .padding()
                               .background(Color.green)
                               .cornerRadius(10)
                       } else {
                           Text("Upload & Recognize Vehicle")
                               .font(.headline)
                               .padding()
                               .frame(maxWidth: .infinity)
                               .background(Color.green)
                               .foregroundColor(.white)
                               .cornerRadius(10)
                       }
                   }
                   .disabled(selectedImage == nil)
                   
                   // Display the API response
                   Text(apiResponse)
                       .padding()
                       .foregroundColor(.black)
                       .multilineTextAlignment(.center)
                   
                   // Display the Google Drive URL
                   if let googleDriveURL = googleDriveURL {
                       Text("File uploaded to Google Drive:")
                       Text(googleDriveURL)
                           .foregroundColor(.blue)
                           .underline()
                   }
            
               }
               .padding()
               .sheet(isPresented: $isImagePickerPresented) {
                   ImagePicker2(selectedImage: $selectedImage, isPresented: $isImagePickerPresented)
               }
           }
           
           // Function to upload the selected image to Google Drive
        /*   func uploadImageToGoogleDrive(image: UIImage) {
               guard let imageData = image.jpegData(compressionQuality: 0.7) else { return }
               isLoading = true
               
               // Construct the URL to your NestJS upload endpoint
               guard let url = URL(string: "http://localhost:3000/auth/postimg") else {
                   apiResponse = "Invalid URL"
                   isLoading = false
                   return
               }
               
               var request = URLRequest(url: url)
               request.httpMethod = "POST"
               request.setValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
               
               // Prepare the image data for multipart form data
               var body = Data()
               let boundary = "Boundary-\(UUID().uuidString)"
               request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
               
               body.append("--\(boundary)\r\n".data(using: .utf8)!)
               body.append("Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
               body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
               body.append(imageData)
               body.append("\r\n".data(using: .utf8)!)
               body.append("--\(boundary)--\r\n".data(using: .utf8)!)
               
               request.httpBody = body
               
               // Make the request to the backend
               let task = URLSession.shared.dataTask(with: request) { data, response, error in
                   DispatchQueue.main.async {
                       isLoading = false
                       if let error = error {
                           apiResponse = "Error: \(error.localizedDescription)"
                           return
                       }
                       
                       guard let data = data else {
                           apiResponse = "No data received"
                           return
                       }
                       
                       // Assuming the backend returns the Google Drive URL
                       if let responseString = String(data: data, encoding: .utf8) {
                           // If response contains the URL
                           googleDriveURL = responseString
                           apiResponse = "File uploaded successfully"
                       }
                   }
               }
               task.resume()
           }*/
    func uploadImageToGoogleDrive(image: UIImage) {
          guard let imageData = image.jpegData(compressionQuality: 0.7) else { return }
          isLoading = true
          
          // Construct the URL to your NestJS upload endpoint
          guard let url = URL(string: "http://localhost:3000/auth/postimg") else {
              apiResponse = "Invalid URL"
              isLoading = false
              return
          }
          
          var request = URLRequest(url: url)
          request.httpMethod = "POST"
          request.setValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
          
          // Prepare the image data for multipart form data
          var body = Data()
          let boundary = "Boundary-\(UUID().uuidString)"
          request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
          
          body.append("--\(boundary)\r\n".data(using: .utf8)!)
          body.append("Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
          body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
          body.append(imageData)
          body.append("\r\n".data(using: .utf8)!)
          body.append("--\(boundary)--\r\n".data(using: .utf8)!)
          
          request.httpBody = body
          
          // Make the request to the backend
          let task = URLSession.shared.dataTask(with: request) { data, response, error in
              DispatchQueue.main.async {
                  isLoading = false
                  if let error = error {
                      apiResponse = "Error: \(error.localizedDescription)"
                      return
                  }
                  
                  guard let data = data else {
                      apiResponse = "No data received"
                      return
                  }
                  
                  // Assuming the backend returns the Google Drive URL
                  if let responseString = String(data: data, encoding: .utf8) {
                      googleDriveURL = responseString
                      apiResponse = "File uploaded successfully"
                      
                      // Call the vehicle recognition API now that we have the Google Drive URL
                      if let googleDriveURL = googleDriveURL {
                          callVehicleRecognitionAPI(withImageURL: googleDriveURL) { response, error in
                              if let error = error {
                                  apiResponse = "Error in vehicle recognition: \(error.localizedDescription)"
                              } else if let response = response {
                                  apiResponse = "Vehicle recognition result: \(response)"
                              }
                          }
                      }
                  }
              }
          }
          task.resume()
      }
       }

#Preview {
    carDetails()
}
