//
//  MessageBubble.swift
//  Project Cars22
//
//  Created by Abderrahmen on 25/11/2024.
//

import SwiftUI

struct MessageBubble: View {
    @State private var showtime = false
    var message:Message
    var body: some View {
        VStack (alignment: message.received ? .leading : .trailing)
        {
            HStack {
                Text(message.text)
                    .padding()
                    .background(message.received ? Color("Gray2") : Color("Bluecar"))
                    .cornerRadius(30)
            }
            .frame(maxWidth: 300, alignment: message.received ? .leading : .trailing)
            .onTapGesture {
                showtime.toggle()
            }
            if(showtime)
            {
                
                Text("\(message.timestamp.formatted(.dateTime.hour().minute()))")
                    .font(.caption2)
                    .foregroundColor(.gray)
                padding(message.received ? .leading : .trailing, 25)
                
            }
        }
        .frame(maxWidth: .infinity, alignment: message.received ? .leading : .trailing)
        .padding(message.received ? .leading : .trailing)
        .padding(.horizontal, 10)
    }
}

#Preview {
    ContentView()
}
