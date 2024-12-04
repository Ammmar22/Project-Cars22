//
//  carvinView.swift
//  Project Cars22
//
//  Created by Abderrahmen on 28/11/2024.
//

import SwiftUI

struct carvinView: View {
    @Environment(\.presentationMode) var presentationMode // Used to go back to the previous view

    @Binding var isConnected: Bool
      @Binding var carDetails: [CarDetail]
    @State private var vin: String = "" // State variable to hold user input
        @State private var errorMessage: String? // To display API response
        @State private var isLoading: Bool = false
    var body: some View {
        ZStack {
            Image("fond2")
                .resizable()             // Make the image resizable
                .scaledToFill()          // Fill the screen with the image, cropping if necessary
                .ignoresSafeArea()
            VStack(spacing: 20) {
                    Text("VIN Decoder")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.white)

                    // TextField for VIN input
                ZStack(alignment: .leading) {
                    if vin.isEmpty { // Show placeholder when the text is empty
                         Text("Enter VIN")
                             .foregroundColor(.white) // Placeholder color
                             .padding(.leading, 5)
                     }
                    TextField("", text: $vin)
                        .foregroundColor(.white)
                        .padding()
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .background(
                                   RoundedRectangle(cornerRadius: 25)
                                       .fill(Color(.systemGray4).opacity(0.2)) // Background color
                                       .shadow(color: .gray, radius: 5) // Optional shadow
                               )
                        .accentColor(.white)
                } // Changes the cursor color to white

                    // Button to trigger the API call
                    Button(action: {
                        decodeVIN(vin: vin)
                    }) {
                        Text("Decode VIN")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .disabled(vin.isEmpty || isLoading) // Disable if VIN is empty or loading

                    // Show loading indicator
                    if isLoading {
                        ProgressView("Loading...")
                    }

                    // Display the API response
                  /*  if let errorMessage = errorMessage {
                                  Text(errorMessage)
                                      .foregroundColor(.red)
                              }

                              // Display car details in a table
                              List(carDetails) { detail in
                                  HStack {
                                      Text(detail.name)
                                          .fontWeight(.bold)
                                          .frame(maxWidth: .infinity, alignment: .leading)
                                      Text(detail.result)
                                          .frame(maxWidth: .infinity, alignment: .trailing)
                                  }
                              }
                              .listStyle(PlainListStyle())*/
                    Spacer()
                }
            .padding()
        }
        }

        // Function to decode VIN
        func decodeVIN(vin: String) {
            guard !vin.isEmpty else { return }

            isLoading = true
            errorMessage = nil
            carDetails = []

            let headers = [
                "x-rapidapi-key": "78dc512ea1msh02dca3dedf60e51p1fbbc6jsn62517e02282c",
                 "x-rapidapi-host": "vin-decoder-europe2.p.rapidapi.com"
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
                                              isConnected = true

                                              carDetails = json.map { CarDetail(name: $0.key, result: "\($0.value)") }
                                              presentationMode.wrappedValue.dismiss()

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
