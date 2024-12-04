//
//  OtpVerificationView.swift
//  Project Cars22
//
//  Created by Abderrahmen on 09/11/2024.
//

import SwiftUI

struct OtpVerificationView: View {
    @Binding var optText :String
    @FocusState private var isKeyboardShowing:Bool
    var body: some View {
        HStack(spacing:0) {
            ForEach(0..<6,id: \.self){
                index in OTPTextBox(index)
            }
        }
        .background(content: {
            TextField("",text: $optText.limit(6))
                .keyboardType(.numberPad)
                .textContentType(.oneTimeCode)
                .frame(width: 1,height: 1)
                .opacity(0.001)
                .blendMode(.screen)
                .focused($isKeyboardShowing)
        })
        .contentShape(Rectangle())
        
        .onTapGesture {
            isKeyboardShowing.toggle()
        }
        .toolbar{
            ToolbarItem(placement: .keyboard) {
                Button("Done"){
                    isKeyboardShowing.toggle()
                }
                .frame(maxWidth: .infinity,alignment: .trailing)
            }
        }
        
    }
    @ViewBuilder
    func OTPTextBox(_ index:Int)->some View {
        ZStack{
            if (optText.count > index) {
                let startIndex = optText.startIndex
                let charIndex = optText.index(startIndex, offsetBy: index)
                let charToString = String(optText[charIndex])
                Text(charToString)
            }else {
                Text(" ")
            }
        }
        .frame(width: 45, height: 45)
        .background{
            RoundedRectangle(cornerRadius: 6, style: .continuous)
                .stroke(.gray,lineWidth: 0.5)
        }
        .frame(maxWidth: .infinity)
    }
    
 
}

#Preview {
    ContentView()
}


extension Binding where Value == String {
    func limit(_ length:Int)->Self{
        if self.wrappedValue.count > length{
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.prefix(length))

            }
        }
        return self
    }
}
