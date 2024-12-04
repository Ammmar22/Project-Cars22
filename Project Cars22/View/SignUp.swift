//
//  SignUp.swift
//  Project Cars22
//
//  Created by Abderrahmen on 02/11/2024.
//

import SwiftUI

struct SignUp: View {
    @ObservedObject private var viewModel = ViewModel()
       @Binding var showSignup: Bool
       @State private var emailID: String = ""
       @State private var password: String = ""
       @State private var FullName: String = ""
       @State private var PhoneNumber: String = ""
    @State private var imageUrl: URL? = nil // To capture the image URL

    @State private var showAlert = false
    @State private var showAlert2 = false


       @State private var selectedGovernorate: String = "Tunis" // Default selection
       @State private var selectedUserRole: String = "User" // Default role
       @State private var selectedUserType: String = "Individual" // Default type
    @State private var selectedImage: UIImage? = nil // Store selected image
       @State private var showImagePicker = false

       let governorates = ["Tunis", "Ariana", "Ben Arous", "Manouba", "Nabeul", "Zaghouan", "Bizerte", "Beja", "Jendouba",
                           "Kef", "Siliana", "Sousse", "Monastir", "Mahdia", "Sfax", "Kairouan", "Kasserine", "Sidi Bouzid",
                           "Gabes", "Mednine", "Tataouine", "Gafsa", "Tozeur", "Kebili"]
       
       let userTypes = ["Individual", "Mechanic", "Dealer"] // List of types

       var body: some View {
           VStack(alignment: .leading, spacing: 15, content: {
               
               Button(action: {
                   showSignup = false
               }, label: {
                   Image(systemName: "arrow.left")
                       .font(.title2)
                       .foregroundStyle(.gray)
               })
               .padding(.top, 10)
               
               Text("SignUp")
                   .font(.largeTitle)
                   .fontWeight(.heavy)
               Text("Please sign up to continue")
                   .font(.callout)
                   .fontWeight(.semibold)
                   .foregroundStyle(.gray)
                   .padding(.top, -5)
               
               VStack(spacing: 25) {
                   /// Custom text fields
                   CustomTF(sfIcon: "at", hint: "Email ID", value: $emailID)
                   CustomTF(sfIcon: "person", hint: "Full Name", value: $FullName)
                       .padding(.top, 5)
                   CustomTF(sfIcon: "lock", hint: "Password", isPassword: true, value: $password)
                   CustomTF(sfIcon: "phone", hint: "Number phone", isPassword: false, value: $PhoneNumber)
                       .padding(.top, 5)
                   VStack {
                       let base64ImageString = "not yet";                                      if let image = selectedImage {
                                          Image(uiImage: image)
                                              .resizable()
                                              .scaledToFill()
                                              .frame(width: 100, height: 100)
                                              .clipShape(Circle())
                                         
                                      } else {
                                          Circle()
                                              .fill(Color.gray.opacity(0.5))
                                              .frame(width: 100, height: 100)
                                              .overlay(Text("Upload Image").foregroundColor(.white))
                                      }
                                  }
                                  .onTapGesture {
                                      showImagePicker = true
                                  }
                                  .padding(.bottom, 10)
                   
                   
                   Text("Select Your Region")
                       .font(.headline)
                       .foregroundColor(.gray)
                   Picker("Governorate", selection: $selectedGovernorate) {
                       ForEach(governorates, id: \.self) { governorate in
                           Text(governorate)
                               .foregroundColor(.gray)
                               .frame(maxWidth: .infinity, alignment: .leading)
                               .padding(.leading, 0)
                       }
                   }
                   .pickerStyle(MenuPickerStyle())
                   .padding(.horizontal, 0)
                   
                
                   
                   Text("Select User Type")
                       .font(.headline)
                       .foregroundColor(.gray)
                   Picker("User Type", selection: $selectedUserType) {
                       ForEach(userTypes, id: \.self) { type in
                           Text(type).foregroundColor(.gray)
                       }
                   }
                   .pickerStyle(MenuPickerStyle())
                   
                   /// Continue button
                   GradientButton(title: "Continue", icon: "arrow.right") {
                      
                       viewModel.signup(image :imageUrl!,email: emailID, password: password, name: FullName,phone :PhoneNumber, role: selectedUserType, region: selectedGovernorate)
                       { isSuccess in
                           if isSuccess {
                              showAlert = false
                               showSignup = false

                           }else {
                               showAlert = true
                           }
                       }
                   }
                   
                   .hSpacing(.trailing)
                   .disableWithOpacity(emailID.isEmpty || password.isEmpty || FullName.isEmpty)
               }
               .padding(.top, 20)
               
               .alert("Alert", isPresented: $showAlert ) {
                          // No custom buttons needed; default "OK" button will appear
                      } message: {
                          Text("Check Your data please .")
                      }
                      .alert("Alert", isPresented: $showAlert2 ) {
                          // No custom buttons needed; default "OK" button will appear
                      } message: {
                          Text("Acount Create  successfully .")
                      }
               Spacer(minLength: 0)
               
               HStack(spacing: 6) {
                   Text("Already have an account?")
                       .foregroundStyle(.gray)
                   Button("Login") {
                       showSignup = false
                   }
                   .fontWeight(.bold)
                   .tint(.app)
               }
               .font(.callout)
               .hSpacing()
           })
           .padding(.vertical, 15)
           .padding(.horizontal, 25)
           .toolbar(.hidden, for: .navigationBar)
           .sheet(isPresented: $showImagePicker) {
               ImagePicker(image: $selectedImage, isImagePickerPresented: $showImagePicker, imageURL: $imageUrl)
                   }
       }
    
    
    // Function to convert UIImage to Base64 string
    func convertImageToBase64String(image: UIImage) -> String? {
        // Convert the image to Data (JPEG format with a compression quality of 0.8)
        if let imageData = image.jpegData(compressionQuality: 0.8) {
            // Encode the Data to a Base64 string
            return imageData.base64EncodedString()
        }
        return nil
    }

    // Usage within your SignUp view
    

    
 
}

#Preview {
    ContentView()
}
