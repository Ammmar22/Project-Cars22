//
//  LanchScreen.swift
//  Project Cars22
//
//  Created by Abderrahmen on 28/11/2024.
//

import SwiftUI

struct LanchScreen: View {
    @State private var currentStep = 0  // Track the current screen
       @State private var showMainApp = false // Flag to show the main app after the 3rd screen
    let onFinish: () -> Void
    


       let images = ["bmw33", "bmw-xm-mi-01", "bmw55"] // Replace with your image names
       let texts = [" Welcome ", "Explore the world of Cars", "Let's start your journey!"] // Text for each screen

       var body: some View {
           ZStack {
               // Background color or image can be added here
               //Color.black.edgesIgnoringSafeArea(.all)

               Image(images[currentStep]) // Change background dynamically
                               .resizable()             // Make the image resizable
                               .scaledToFill()          // Fill the screen with the image, cropping if necessary
                               .ignoresSafeArea()
               
               VStack {
                   // Dots Indicator at the top
                  
//                   .padding(.top, 40) // Position dots at the top

                   if currentStep > 0 {
                                      // Show text at the top for second and third steps
                                      Text(texts[currentStep])
                                          .foregroundColor(.white)
                                          .padding(.top, 50)
                                          .font(.system(size: 30, weight: .semibold, design: .serif)) // Elegant serif font
                                              .italic()// Small padding at the top
                                  }

                   // Display image for the current step
                  /* Image(images[currentStep])
                       .resizable()
                       .scaledToFit()
                       .frame(width: 300, height: 300)
                       .padding()*/

                   // Display the text for the current step
                   if currentStep == 0 {
                       GeometryReader { geometry in
                              VStack {
                                  Spacer() // Push the content downward

                                  Text(texts[currentStep])
                                      .font(.system(size: 40, weight: .semibold, design: .serif)) // Elegant serif font
                                          .italic()                                      .foregroundColor(.white)
                                      .padding(.bottom, geometry.safeAreaInsets.bottom + 70) // Add space from the screen's edge
                              }
                              .frame(width: geometry.size.width, height: geometry.size.height, alignment: .bottom) // Align to bottom
                          }
                                 }

                   Spacer()
                   HStack(spacing: 15) {
                       ForEach(0..<3, id: \.self) { index in
                           Circle()
                               .fill(self.currentStep == index ? Color("Bluecar") : Color.gray) // Only the current dot is green

                               .frame(width: 10, height: 40)
                       }
                   }

                   // Next button
                   if currentStep < 2 {
                       Button(action: {
                           currentStep += 1
                       }) {
                           Text("Next")
                                   .font(.headline)
                                   .foregroundColor(.blue) // Text color
                                   .padding()
                                   .background(Color.white.opacity(0.5)) // Transparent blue background
                                   .cornerRadius(10) // Rounded corners
                                 
                       }
                   } else {
                       // On the last screen, move to the main app
                       Button(action: {
                           showMainApp = true
                           onFinish()

                       }) {
                           Text("Start")
                                   .font(.headline)
                                   .foregroundColor(.white) // Text color
                                   .padding()
                                   .background(Color.green.opacity(0.5)) // Transparent blue background
                                   .cornerRadius(10) // Rounded corners
                                   .overlay(
                                       RoundedRectangle(cornerRadius: 10)
                                           .stroke(Color.green, lineWidth: 2) // Add a border for better visibility
                                   )
                       }
                   }
               }
               .onChange(of: currentStep) { newValue in
                   if newValue == 3 {
                       // Navigate to the main screen when done
                       DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                           showMainApp = true
                       }
                   }
               }

               // When the final screen is reached, navigate to the main app screen
               if showMainApp {
                   ContentView() // Replace with your actual main screen view
                                     .transition(.move(edge: .trailing))
               }
               
           }        .animation(.easeInOut, value: showMainApp)

       }
}

#Preview {
    ContentView()
}
