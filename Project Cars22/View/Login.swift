//
//  Login.swift
//  Project Cars22
//
//  Created by Abderrahmen on 02/11/2024.
//

import SwiftUI




struct Login: View {
    @State private var showAlert = false

    @AppStorage("authToken") private var authToken: String?
    @ObservedObject private var viewModel = ViewModel()
    @Binding var showSignup: Bool
    @Binding var showMainPage: Bool
    @State private var emailID: String = ""
    @State private var password: String = ""
    @State private var showForgotPassword: Bool = false
    @State private var showResetView: Bool = false
    @State private var askOTP: Bool = false
    @State private var otpText: String = ""


    
    


    


    var body: some View {
        VStack(alignment: .leading, spacing: 15, content: {
            Image("engineering-4")
                .resizable()
                .frame(width: 100, height: 100)
                .padding(.horizontal, 120) // Add
                .padding(.top, 120)
                .blur(radius: 0)
// Add

            Text("Login")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top, 50)
            Text("please sign in to continue")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.top,-5)
            VStack(spacing: 25)
            {
                /// Custom text Fields
                CustomTF(sfIcon: "at", hint: "email ID", value: $emailID)
                CustomTF(sfIcon: "lock", hint: "Password",isPassword: true,value: $password)
                    .padding(.top, 5)
                
                Button("Forgot Password") {
                    showForgotPassword.toggle()
                    
                }
                .font(.callout)
                .fontWeight(.heavy)
                .tint(.app)
                .hSpacing(.trailing)
                
                /// Login Button
                GradientButton(title: "Login", icon: "arrow.right") {
                    viewModel.login(email: emailID , password: password)
                    { isSuccess in
                        if isSuccess {
                            if(viewModel.isAuthenticated)
                            { showMainPage = true
                                print(viewModel.id!,"this id")
                            }
                            
                        }else {
                            print("koskous")
                            showAlert = true
                        }
                    }
                    
                } .alert("Alert", isPresented: $showAlert ) {
                    // No custom buttons needed; default "OK" button will appear
                } message: {
                    Text("Check Your Email and Password please .")
                }
                .hSpacing(.trailing)
                /// Disabling Until the data is Entered
                .disableWithOpacity(emailID.isEmpty || password.isEmpty )
            }
            .padding(.top, 20)
            .alert("Alert", isPresented: $showAlert ) {
                       // No custom buttons needed; default "OK" button will appear
                   } message: {
                       Text("Check Your Email and Password please .")
                   }
            Spacer(minLength: 0)
            
            HStack(spacing: 6){
                
                Text("Don't have an account?")
                    .foregroundStyle(.gray)
                Button("SignUp") {
                    showSignup.toggle()
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
        .onAppear {
                  // Clear email and password when the view appears
                  emailID = ""
                  password = ""
              }
        /// Asking email For Sending reset Link
        .sheet(isPresented: $showForgotPassword, content: {
            if #available(iOS 16.4, *) {
                ForgotPassword(showRestView: $showResetView, askOTP: $askOTP)
                    .presentationDetents([.height(300)])
                    .presentationCornerRadius(30)
            } else {
                ForgotPassword(showRestView: $showResetView, askOTP: $askOTP)
                    .presentationDetents([.height(300)])
            }
        })
        /// Reseting New Password
        .sheet(isPresented: $showResetView, content: {
        if #available(iOS 16.4, *) {
            PasswordResetView()
                .presentationDetents([.height(300)])
                .presentationCornerRadius(30)
        } else {
            PasswordResetView()
                .presentationDetents([.height(300)])
        }
    })
        /// OTP New Password
        .sheet(isPresented: $askOTP, content: {
        if #available(iOS 16.4, *) {
            OtpView(otpText: $otpText, showRestView: $showResetView)
                .presentationDetents([.height(300)])
                .presentationCornerRadius(30)
        } else {
            OtpView(otpText: $otpText, showRestView: $showResetView)
                .presentationDetents([.height(300)])
        }
    })
        

   }
}

#Preview {
    ContentView()
}
