//
//  menu.swift
//  Project Cars22
//
//  Created by Abderrahmen on 28/11/2024.
//

import SwiftUI

struct menu: View {
    @Binding var showmainPage: Bool
    @State var navigateToParm:Bool = false
    @State private var errorMessage: String?
    @State private var isLoading: Bool = false
    @State private var showMessages = false // Toggle for dropdown
    @EnvironmentObject var viewModel: ViewModel
    @State private var id = UserDefaults.standard.string(forKey: "userId") ?? "Guest"
    @State private var token = UserDefaults.standard.string(forKey: "authToken") ?? "Guest"

    @State private var isConnected = false // Change this based on car detail availability
    @State private var carDetails: [CarDetail] = [] // List of car details
    @State private var showCarDetailView = false // Controls whether the car detail sheet is shown

    @State private var vin: String = "" // State variable to hold user input
    
    
    @State private var bookings: [Booking] = []
    
   /* private var pendingMessagesCount: Int {
        bookings.filter { $0.etat != 0 && $0.vu == false && $0.userId == user._id }.count
    }*/
    var body: some View {
        ZStack {
            
            Image("fond2")
                .resizable()             // Make the image resizable
                .scaledToFill()          // Fill the screen with the image, cropping if necessary
                .ignoresSafeArea()
            VStack {
                
                HStack {
                    Spacer()
                    
                    // Message Icon
                    Button(action: {
                        withAnimation {
                            showMessages.toggle()
                        }
                    }) {
                        ZStack {
                            Image(systemName: "envelope.fill")
                                .resizable()
                                .frame(width: 30, height: 20)
                                .foregroundColor(.white)
                            if let user = viewModel.user {
                                if  bookings.filter { $0.etat != 0 && $0.vu == false && $0.userId == user._id }.count > 0 {
                                    Text("\(bookings.filter { $0.etat != 0 && $0.vu == false && $0.userId == user._id }.count  )")
                                        .font(.caption2)
                                        .bold()
                                        .foregroundColor(.white)
                                        .frame(width: 18, height: 18)
                                        .background(Color.red)
                                        .clipShape(Circle())
                                        .offset(x: 12, y: -8)
                                }
                            }
                        }
                      
                    }
              
                    .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
               // .background(Color.black.opacity(0.4))
                .onAppear {
                  isLoading = true
            
                  viewModel.fetchUser(id2: id, token2: token) { success in
                      DispatchQueue.main.async {
                          isLoading = false
                      }
                  }
              }
                
                
                
                
                ScrollView {
                    VStack {
                        Text("Smart \n  Car scaner ")
                            .font(.system(size: 50, weight: .bold)) // Make text larger and bold
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                            .padding(.top, 50) // Add padding to move
                        
                        Image("blackcar1") // Replace with your image name
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200) // Adjust the
                        
                        ZStack {
                            // Box background
                            Color(.systemGray4).opacity(0.2) // Grey with a subtle hint of blue and semi-transparency
                                .cornerRadius(25) // Rounded corners
                                .frame(height: 70)
                                .padding(.horizontal, 20)
                            
                            // Box content
                            HStack {
                                // Connection status text
                                VStack(alignment: .leading) {
                                    Text(isConnected ? "Connected" : "Please connect Your car")
                                    
                                    
                                        .font(.headline)
                                        .bold()
                                        .foregroundColor(isConnected ? .green : .red) // Dynamic color
                                        .padding(.bottom, 5)
                                        .padding(.horizontal, 25)
                                    
                                    
                                    
                                }
                                
                                Spacer() // Push the arrow to the right
                                
                                if !isConnected {
                                    NavigationLink(destination: carvinView(isConnected: $isConnected, carDetails: $carDetails)) {
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.white)
                                            .padding()
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        .padding(.top, 30) // Add space between image and box
                        HStack {
                            ZStack {
                                Color(.bluecar).opacity(0.2) // Grey with a subtle hint of blue and semi-transparency
                                    .cornerRadius(25) // Rounded corners
                                    .frame(height: 170)
                                    .padding(.horizontal, 10)
                                
                                
                                
                                // Box content
                                HStack {
                                    // Deatils car
                                    VStack(alignment: .leading) {
                                        Text("Details about your car")
                                            .font(.headline)
                                            .bold()
                                            .multilineTextAlignment(.center) // Center text horizontally
                                        
                                            .foregroundColor(.white) // Dynamic color
                                            .padding(.bottom, 5)
                                            .padding(.horizontal, 10)
                                            .onTapGesture {
                                                // Show car detail view when tapped
                                                showCarDetailView = true
                                            }
                                        
                                        if !isConnected {
                                            
                                        }
                                    }
                                    
                                    Spacer() // Push the arrow to the right
                                    
                                    
                                }
                                .padding(.horizontal, 20)
                                
                            }
                            .padding(.top, 30)
                            ZStack {
                                // Box background
                                Color(.bluecar).opacity(0.2) // Grey with a subtle hint of blue and semi-transparency
                                    .cornerRadius(25) // Rounded corners
                                    .frame(height: 170)
                                    .padding(.horizontal, 10)
                                
                                // Box content
                                HStack {
                                    // Connection status text
                                    VStack(alignment: .leading) {
                                        Text("Contact Mechanical")
                                            .font(.headline)
                                            .bold()
                                            .foregroundColor(.white) // Dynamic color
                                            .padding(.bottom, 5)
                                            .padding(.horizontal, 25)
                                            .multilineTextAlignment(.center) // Center text horizontally
                                        
                                        
                                        if !isConnected {
                                            
                                        }
                                    }
                                    
                                    Spacer() // Push the arrow to the right
                                    
                                    
                                }
                                .padding(.horizontal, 20)
                            }
                            .padding(.top, 30)
                            
                        } // Add space between image
                        HStack {
                            ZStack {
                                Color(.bluecar).opacity(0.2) // Grey with a subtle hint of blue and semi-transparency
                                    .cornerRadius(25) // Rounded corners
                                    .frame(height: 170)
                                    .padding(.horizontal, 10)
                                
                                
                                
                                // Box content
                                NavigationLink (destination: ViewMap()) {
                                    HStack {
                                        // Deatils car
                                        VStack(alignment: .leading) {
                                            Text("Map")
                                                .font(.headline)
                                                .bold()
                                                .multilineTextAlignment(.center) // Center text horizontally
                                            
                                                .foregroundColor(.white) // Dynamic color
                                                .padding(.bottom, 5)
                                                .padding(.horizontal, 50)
                                            
                                            if !isConnected {
                                                
                                            }
                                        }
                                        
                                        Spacer() // Push the arrow to the right
                                        
                                        
                                    }
                                    .padding(.horizontal, 20)
                                }
                                
                            }
                            .padding(.top, 30)
                            ZStack {
                                // Box background
                                Color(.bluecar).opacity(0.2) // Grey with a subtle hint of blue and semi-transparency
                                    .cornerRadius(25) // Rounded corners
                                    .frame(height: 170)
                                    .padding(.horizontal, 10)
                                
                                // Box content
                                NavigationLink(destination: NewsFeedView()) {
                                    HStack {
                                        // Connection status text
                                        VStack(alignment: .leading) {
                                            Text("News")
                                                .font(.headline)
                                                .bold()
                                                .foregroundColor(.white) // Dynamic color
                                                .padding(.bottom, 5)
                                                .padding(.horizontal, 25)
                                                .multilineTextAlignment(.center) // Center text horizontally
                                            
                                            
                                            if !isConnected {
                                                
                                            }
                                        }
                                        
                                        Spacer() // Push the arrow to the right
                                        
                                        
                                    }
                                    .padding(.horizontal, 20)
                                }
                            }
                            .padding(.top, 30)
                            
                        } // Add space between image
                        
                        
                        Spacer()
                        
                        // Push everything up
                    }
                    
                }
                HStack {
                    // Menu Icon
                    Button(action: {
                        print("Menu button tapped")
                    }) {
                        VStack {
                            Image(systemName: "list.dash")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                            Text("Menu")
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                    
                    Spacer()
                    
                    // Parameter Icon
                    Button(action: {
                        print("Parameters button tapped")
                        navigateToParm = true
                    }) {
                        VStack {
                            Image(systemName: "gearshape.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                            Text("Parameters")
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                    }
                    
                    
                    .padding()
                    .background(
                        NavigationLink(
                            destination: userdetails(showmainPage: $showmainPage), // Replace `LoginView` with your actual login page view
                            isActive: $navigateToParm,
                            label: { EmptyView() }
                        )
                    )
                }
                
                .frame(height: 80)
                .background(Color.black.opacity(0.8))
                .cornerRadius(15)
                .padding([.leading, .trailing], 20)
            }
            if showMessages {
                if let user = viewModel.user {

                VStack(alignment: .leading, spacing: 10) {
                    ForEach(bookings.filter { $0.etat != 0 && $0.vu == false && $0.userId == user._id }, id: \.id) { booking in
                        VStack(alignment: .leading) {
                            Text("Your Booking with date : \(booking.date) is \(statusText(for: booking.etat)) ")
                                .font(.subheadline)
                                .foregroundColor(.primary)
                                .padding(.bottom, 5)
                            
                            HStack {
                                Button(action: {
                                    if let user = viewModel.user {
                                        
                                        print("Accepted message \(booking.id)")
                                        viewModel.updateBookingVu(id: booking.id, newVu: true) // 1 represents accepted
                                        withAnimation {
                                            // Hide the message after accepting
                                            bookings.removeAll { $0.id == booking.id }
                                        }
                                    }
                                }) {
                                    Text("OK")
                                        .bold()
                                        .frame(maxWidth: .infinity)
                                        .padding()
//                                        .background(Color.green.opacity(0.8))
                                        .background(booking.etat == 1 ? .green.opacity(0.8) : .red.opacity(0.8)) // Dynamic color

                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                
                            }
                            .padding(.bottom, 5)
                            .padding(.horizontal, 40)
                        }
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }
                }
                .padding()
                .background(Color.black.opacity(0.3))
                .cornerRadius(12)
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity, alignment: .topTrailing)
                .offset(y: 80) // Adjust to place it below the icon
            }
                
            }

                }
//        .navigationBarTitle("Menu", displayMode: .inline)
        .navigationBarBackButtonHidden(true) // This hides the back button
        .sheet(isPresented: $showCarDetailView) {
            carDetailsview(carDetails: $carDetails)
                    }

                .onTapGesture {
                    // Handle tap to navigate or show VIN input screen
                    if !isConnected {
                        print("Navigate to VIN input screen")
                    }
                }
                .onAppear {
                    isLoading = true
                    viewModel.Bookings() { isSuccess in
                        DispatchQueue.main.async {
                            isLoading = false
                            if isSuccess! {
                                bookings = viewModel.bookings
                            } else {
                                errorMessage = "Failed to load bookings"
                            }
                        }
                    }
                    viewModel.fetchUser(id2: id, token2: token) { success in
                        DispatchQueue.main.async {
                            isLoading = false
                        }
                    }
                }
            }
    
    
    
    
    private func statusText(for etat: Int) -> String {
        switch etat {
        case 0: return "Pending"
        case 1: return "Accepted"
        case 2: return "Rejected"
        default: return "Unknown"
        }
    }
    
    func decodeVIN(vin: String) {
        guard !vin.isEmpty else { return }

        isLoading = true
        errorMessage = nil
        carDetails = []

        let headers = [
            "x-rapidapi-key": "40749a7270msh4b1b60b2bcf3203p156369jsn83c66b79b545",
             "x-rapidapi-hos": "vin-decoder-europe2.p.rapidapi.com"
        ]

        guard let url = URL(string: "https://vin-decoder-europe2.p.rapidapi.com/vin_decoder?vin=\(vin)") else {
                   errorMessage = "Invalid URL."
                   isLoading = false
                   return
               }

        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                isLoading = false


                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    errorMessage = "Invalid Response."

                    return
                }

                if let data = data, let jsonResponse = String(data: data, encoding: .utf8) {
                    do {
                                      // Decode the JSON response
                                      if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                                          carDetails = json.map { CarDetail(name: $0.key, result: "\($0.value)") }
                                      } else {
                                          errorMessage = "Invalid response format."
                                      }
                                  } catch {
                                      errorMessage = "Failed to decode JSON: \(error.localizedDescription)"
                                  }
                } else {
                    errorMessage = "Failed to decode response."
                }
            }
        }

        dataTask.resume()
    }
    }
    
    






#Preview {
    ContentView()
}
