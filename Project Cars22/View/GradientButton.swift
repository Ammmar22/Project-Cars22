//
//  GradientButton.swift
//  Project Cars22
//
//  Created by Abderrahmen on 02/11/2024.
//

import SwiftUI

struct GradientButton: View {
    
    var title: String
    var icon: String
    var onClick: () -> ()
    var body: some View {
        Button(action: onClick, label: {
            HStack(spacing: 15) {
                Text(title)
                Image(systemName: icon)
            }
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .padding(.vertical,12)
            .padding(.horizontal,35)
            .background(.linearGradient(colors: [ .blue,.blue, .app], startPoint: .top, endPoint: .bottom ), in: .capsule)
        })
    }
}

#Preview {
    ContentView()
}
