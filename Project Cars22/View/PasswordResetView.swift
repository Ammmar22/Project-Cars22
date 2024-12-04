//
//  PasswordResetView.swift
//  Project Cars22
//
//  Created by Abderrahmen on 02/11/2024.
//

import SwiftUI

struct PasswordResetView: View {
    @State private var password: String = ""
    @State private var confirmpassword: String = ""
    @ObservedObject private var viewModel = ViewModel()
    @State private var showAlert = false
    @State private var showAlert2 = false



    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15, content: {
            Button(action: {
              dismiss()
            }, label: {
                Image(systemName: "xmark")
                    .font(.title2)
                    .foregroundStyle(.gray)
            })
            .padding(.top, 10)
            Text("Rest Password?")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top, 5)
         
            VStack(spacing: 25)
            {
                /// Custom text Fields
                CustomTF(sfIcon: "lock", hint: "Password",isPassword: true,value: $password)
                CustomTF(sfIcon: "lock", hint: "Confirm Password",isPassword: true,value: $confirmpassword)
                    .padding(.top, 5)
            
            
                /// Login Button
                GradientButton(title: "Send Link", icon: "arrow.right") {
                    viewModel.RestPassword(password: password)
                    { isSuccess in
                        if isSuccess {
                           showAlert = true
                        }else {
                            showAlert2 = true
                        }
                    }                    /// Reset Password
             
                    
                }  .alert("Alert", isPresented: $showAlert ) {
                    // No custom buttons needed; default "OK" button will appear
                } message: {
                    Text("Your paswword update succeful.")
                }
                .alert("Alert", isPresented: $showAlert2 ) {
                    // No custom buttons needed; default "OK" button will appear
                } message: {
                    Text("Password must be more 6 charctere.")
                }
                .hSpacing(.trailing)
                /// Disabling Until the data is Entered
                .disableWithOpacity(password.isEmpty || confirmpassword.isEmpty || password != confirmpassword) 
            }
            .padding(.top, 20)
    
        })
        .padding(.vertical, 15)
        .padding(.horizontal, 25)
        /// since this is gioing to be a shhet
        .interactiveDismissDisabled()
    }
}

#Preview {
    ContentView()
}
