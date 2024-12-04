//
//  ForgotPassword.swift
//  Project Cars22
//
//  Created by Abderrahmen on 02/11/2024.
//

import SwiftUI

struct ForgotPassword: View {
    @Binding var showRestView: Bool
    @State private var emailID: String = ""
    @Binding  var askOTP: Bool
    @State private var otpText: String = ""
    @ObservedObject private var viewModel = ViewModel()

    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15, content: {
            Button(action: {
              dismiss()
            }, label: {
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .foregroundStyle(.gray)
            })
            .padding(.top, 10)
            Text("Forogt Password?")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top, 5)
            Text("please enter your Email so that we can send the rest link")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.top,-5)
            VStack(spacing: 25)
            {
                /// Custom text Fields
                CustomTF(sfIcon: "at", hint: "email ID", value: $emailID)
            
            
                /// Login Button
                GradientButton(title: "Send Link", icon: "arrow.right") {
                    /// Your Code
                    viewModel.Forgotpassword(email: emailID)
                    ///
                    Task {
                        dismiss()
                        try? await Task.sleep(for: .seconds(1))
                        askOTP = true
                        
                    }
                    
                    
                }
                .hSpacing(.trailing)
                /// Disabling Until the data is Entered
                .disableWithOpacity(emailID.isEmpty)
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
