//
//  ChatView.swift
//  Project Cars22
//
//  Created by Abderrahmen on 25/11/2024.
//

import SwiftUI

struct ChatView: View {
    @StateObject var messagesManager = MessagesManager()

   /* var messagesManager = ["hello you", "How are you doing ? ","i have building application swiftUI"]*/
    
    var body: some View {
        VStack {
                  VStack {
                      TitleRow()
                      
                      ScrollViewReader { proxy in
                          ScrollView {
                              ForEach(messagesManager.messages, id: \.id) { message in
                                                         MessageBubble(message: message)
                                                     }
                          }
                          .padding(.top, 10)
                          .background(.white)
                          .cornerRadius(30, corners: [.topLeft, .topRight]) // Custom cornerRadius modifier added in Extensions file
                        /*  .onChange(of: messagesManager.lastMessageId) { id in
                              // When the lastMessageId changes, scroll to the bottom of the conversation
                              withAnimation {
                                  proxy.scrollTo(id, anchor: .bottom)
                              }
                          }*/
                      }
                  }
                  .background(Color("Bluecar"))
                  
                  MessageField()
//                      .environmentObject(messagesManager)
              }
          }
}

#Preview {
    ChatView()
}
