//
//  carDetailsview.swift
//  Project Cars22
//
//  Created by Abderrahmen on 28/11/2024.
//

import SwiftUI

struct carDetailsview: View {
    @Binding var carDetails: [CarDetail]

    var body: some View {
        if(!carDetails.isEmpty){
            List(carDetails) { detail in
                HStack {
                    Text(detail.name)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(detail.result)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            .listStyle(PlainListStyle())
        }else {
            Text("please connect your car first")
                .foregroundStyle(Color.red)
        }
    }
}

#Preview {
    ContentView()
}
