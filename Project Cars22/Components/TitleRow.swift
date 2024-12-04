//
//  TitleRow.swift
//  Project Cars22
//
//  Created by Abderrahmen on 25/11/2024.
//

import SwiftUI

struct TitleRow: View {
    @EnvironmentObject var viewModel: ViewModel
    @State private var id = UserDefaults.standard.string(forKey: "userId") ?? "Guest"
    @State private var token = UserDefaults.standard.string(forKey: "authToken") ?? "Guest"
    
    var body: some View {
        ZStack
        {
            Color("Bluecar") // Debugging background color
                            .edgesIgnoringSafeArea(.all)

                              
            HStack(spacing: 20){
                
                if let user = viewModel.user {
                    if let imageURL = URL(string: user.image){
                        AsyncImage(url: imageURL){
                            image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 50)
                                .cornerRadius(50)
                        } placeholder: {
                            ProgressView()
                        }
                        VStack(alignment: .leading){
                            Text(user.name)
                                .font(.title).bold()
                            Text("Online")
                                                .font(.caption)
                                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                                  
                                  Image(systemName: "phone.fill")
                                      .foregroundColor(.gray)
                                      .padding(10)
                                      .background(.white)
                                      .cornerRadius(50)
                        
                    }

                }
       
            } .onAppear {
                viewModel.fetchUser(id2: id, token2: token) { success in
                    DispatchQueue.main.async {
                    }
                }
            }
        }             .frame(height: 100) // Set height for the background and content section
        Spacer()
    }
}




 struct TitleRow_Previews: PreviewProvider{
 static var previews: some View {
 TitleRow()
 .background(Color("Bluecar"))
 }
 }
 

#Preview {
    TitleRow().background(Color.blue)
}

