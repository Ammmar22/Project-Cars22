//
//  MessagesManager.swift
//  ChatApp
//
//  Created by Stephanie Diep on 2022-01-11.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


class MessagesManager: ObservableObject {
    @Published private(set) var messages: [Message] = []
    
    // Create an instance of our Firestore database
    let db = Firestore.firestore()
    
    // On initialize of the MessagesManager class, get the messages from Firestore
    init() {
        getMessages()
    }

    // Read message from Firestore in real-time with the addSnapShotListener
    func getMessages() {
        
    
        print("hahaha33")

        db.collection("messages").addSnapshotListener { querySnapshot, error in
            
            // If we don't have documents, exit the function
            guard let documents = querySnapshot?.documents else {
                print("kaka")

                print("Error fetching documents: \(String(describing: error))")
                return
            }
            print("hahaha332")

            // Mapping through the documents
            self.messages = documents.compactMap { document -> Message? in
                do {
                    print("Laminelal")

                    // Converting each document into the Message model
                    // Note that data(as:) is a function available only in FirebaseFirestoreSwift package - remember to import it at the top
                    return try document.data(as: Message.self)
                } catch {
                    // If we run into an error, print the error in the console
                    print("Error decoding document into Message: \(error)")

                    // Return nil if we run into an error - but the compactMap will not include it in the final array
                    return nil
                }
            }
            
            // Sorting the messages by sent date
            
            // Getting the ID of the last message so we automatically scroll to it in ContentView
          
        }
    }
    
    // Add a message in Firestore
    /*func sendMessage(text: String) {
        do {
            // Create a new Message instance, with a unique ID, the text we passed, a received value set to false (since the user will always be the sender), and a timestamp
            let newMessage = Message(id: "\(UUID())", text: text, received: false, timestamp: Date())
            
            // Create a new document in Firestore with the newMessage variable above, and use setData(from:) to convert the Message into Firestore data
            // Note that setData(from:) is a function available only in FirebaseFirestoreSwift package - remember to import it at the top
            try db.collection("messages").document().setData(from: newMessage)
            
        } catch {
            // If we run into an error, print the error in the console
            print("Error adding message to Firestore: \(error)")
        }
    }*/
}
