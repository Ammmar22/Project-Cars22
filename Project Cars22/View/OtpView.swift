//
//  ForgotPassword.swift
//  Project Cars22
//
//  Created by Abderrahmen on 02/11/2024.
//

import SwiftUI

struct OtpView: View {
    @Binding var otpText: String
    @Binding var showRestView: Bool
    @ObservedObject private var viewModel = ViewModel()
    @State private var showAlert = false


    
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
            Text("Enter OTP ")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top, 5)
            Text("A 6 Digits Code has sent to your email")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.top,-5)
            VStack(spacing: 25)
            {
                /// Custom text Fields
            OtpVerificationView(optText: $otpText)
            
                /// Login Button
                GradientButton(title: "Send", icon: "arrow.right") {
                    /// Your Code
                    viewModel.verifyotp(codeotp: otpText) { isSuccess in
                        if isSuccess {
                            Task {
                                dismiss()
                                try? await Task.sleep(for: .seconds(1))
                                showRestView = true
                            }
                        } else {
                            showAlert = true
                        }
                    }
              
                    
                }
                .hSpacing(.trailing)
                /// Disabling Until the data is Entered
                .disableWithOpacity(otpText.isEmpty)
            }
            .alert("Alert", isPresented: $showAlert ) {
                       // No custom buttons needed; default "OK" button will appear
                   } message: {
                       Text("Check Your OTP.")
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

extension View {
    func disableWithopacity(_ condition: Bool)->some View {
        self
            .disabled(condition)
            .opacity(condition ? 0.6 : 1)
    }
}

