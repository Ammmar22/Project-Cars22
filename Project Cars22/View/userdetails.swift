//
//  userdetails.swift
//  Project Cars22
//
//  Created by Abderrahmen on 19/11/2024.
//

import SwiftUI

struct userdetails: View {
    @State private var showAlert = false
    @State private var isEditing = false // Tracks whether the fields are editable
    @Binding var showmainPage: Bool
    @EnvironmentObject var viewModel: ViewModel
    @State private var isLoading = true // State to track loading
    @State private var id = UserDefaults.standard.string(forKey: "userId") ?? "Guest"
    @State private var token = UserDefaults.standard.string(forKey: "authToken") ?? "Guest"
    @State private var navigateToLogin = false // State to control navigation
    @State var navigateToParm:Bool = false

    // Editable fields
    @State private var email = ""
    @State private var phoneNumber = ""
    @State private var region = ""
    @State private var role = ""

    var body: some View {
        
        ZStack {
            Image("fond2")
                .resizable()             // Make the image resizable
                .scaledToFill()          // Fill the screen with the image, cropping if necessary
                .ignoresSafeArea()
            VStack {
                if isLoading {
                    // Loading indicator when fetching user details
                    ProgressView("Loading user details...")
                        .padding()
                } else {
                    if let user = viewModel.user {
                        VStack {
                            if let imageURL = URL(string: user.image),
                               let imageData = try? Data(contentsOf: imageURL),
                               let uiImage = UIImage(data: imageData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 130, height: 130)
                                    .clipShape(Circle())
                                    .padding(.top, 120)
                            } else {
                                Image(systemName: "person.crop.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(Color("Bluecar")) // Ensure the color makes the icon visible
                                    .padding(.top, 60)
                            }
                        }
                        .onAppear {
                            // Populate state variables
                            email = user.email
                            phoneNumber = user.phoneNumber
                            region = user.region
                            role = user.role
                        }
                        Spacer()
                        VStack(alignment: .leading, spacing: 10) {
                            // Editable fields
                            HStack {
                                Text("Email:")
                                    .font(.headline)
                                    .foregroundStyle(Color.white)
                                Spacer()
                                if isEditing {
                                    TextField("Email", text: $email)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                } else {
                                    Text(email)
                                        .foregroundColor(.gray)
                                }
                            }
                            Divider().background(Color.black.opacity(0.3))
                            
                            HStack {
                                Text("Phone Number:")
                                    .font(.headline)
                                    .foregroundStyle(Color.white)

                                Spacer()
                                if isEditing {
                                    TextField("Phone Number", text: $phoneNumber)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                } else {
                                    Text(phoneNumber)
                                        .foregroundColor(.gray)
                                }
                            }
                            Divider().background(Color.black.opacity(0.3))
                            
                            HStack {
                                Text("Region:")
                                    .font(.headline)
                                    .foregroundStyle(Color.white)

                                Spacer()
                                if isEditing {
                                    TextField("Region", text: $region)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                } else {
                                    Text(region)
                                        .foregroundColor(.gray)
                                }
                            }
                            Divider().background(Color.black.opacity(0.3))
                            
                            HStack {
                                Text("Role:")
                                    .font(.headline)
                                    .foregroundStyle(Color.white)

                                Spacer()
                                if isEditing {
                                    TextField("Role", text: $role)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                } else {
                                    Text(role)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .padding(.horizontal)
                        Spacer()
                        
                        
                        // Modify and Save Buttons
                        if isEditing {
                            Button(action: {
                                // Save the updated details
                                viewModel.updateUser(
                                    id: id,
                                    token: token,
                                    email: email,
                                    phoneNumber: phoneNumber,
                                    region: region,
                                    role: role
                                ) { success in
                                    if success {
                                        isEditing = false
                                    }
                                }
                            }) {
                                Text("Save Changes")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.green)
                                    .cornerRadius(10)
                            }
                            .padding()
                        } else {
                            Button(action: {
                                isEditing = true
                            }) {
                                Text("Modify")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            }
                            .padding()
                        }  
                        Button(action: {
                            showAlert = true
                        }) {
                            Text("Delete Account")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.red)
                                .cornerRadius(10)
                        }
                        .padding()
                                                 .alert(isPresented: $showAlert) {
                                                     Alert(
                                                         title: Text("Are you sure?"),
                                                         message: Text("This action will permanently delete your account."),
                                                         primaryButton: .destructive(Text("Delete")) {
                                                             viewModel.deleteUser(id: id) { isSuccess in
                                                                 if isSuccess {
                                                                     viewModel.logout() { isSuccess in
                                                                         if isSuccess {
                                                                             showmainPage = false
                                                                         }
                                                                     }
                                                                 }
                                                             }
                                                         },
                                                         secondaryButton: .cancel()
                                                     )
                                                 }
                        
                        Spacer()
                    } else {
                        Text("No user details found.")
                            .foregroundColor(.red)
                    }
                    Spacer()
                    HStack {
                        // Menu Icon
                        Button(action: {
                            print("Menu button tapped")
                            navigateToParm = true

                        }) {
                            VStack {
                                Image(systemName: "list.dash")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.white)
                                Text("Menu")
                                    .font(.caption)
                                    .foregroundColor(.white)
                            }
                        }
                        .padding()
                        .background(
                            NavigationLink(
                                destination: ContentView(), // Replace `LoginView` with your actual login page view
                                isActive: $navigateToParm,
                                label: { EmptyView() }
                            )
                        )
                        Spacer()
                        
                        // Parameter Icon
                        Button(action: {
                            print("Parameters button tapped")
                        }) {
                            VStack {
                                Image(systemName: "gearshape.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.white)
                                Text("Parameters")
                                    .font(.caption)
                                    .foregroundColor(.white)
                            }
                        }
                        .padding()
                     
                    }
                    .frame(height: 80)
                    .background(Color.black.opacity(0.8))
                    .cornerRadius(15)
                    .padding([.leading, .trailing], 20)
                    .padding(.bottom, 20) // Adjust this value to move the bar higher

                }
            }
            .navigationTitle("User Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.logout() { isSuccess in
                            if isSuccess {
                              
                                showmainPage = false
                                navigateToLogin = true // Set to true to trigger navigation

                            }
                        }
                    }) {
                        Image(systemName: "door.left.hand.open")
                            .font(.title)
                            .foregroundColor(Color("Bluecar")) // Ensure the color makes the icon visible

                    }.background(
                        NavigationLink(
                            destination: ContentView(), // Replace `LoginView` with your actual login page view
                            isActive: $navigateToLogin,
                            label: { EmptyView() }
                        )
                    )
                }
            }
        }
        .onAppear {
            viewModel.fetchUser(id2: id, token2: token) { success in
                DispatchQueue.main.async {
                    isLoading = false
                }
            }
        }
    }
}

#Preview {
    ContentView().environmentObject(ViewModel())
}
