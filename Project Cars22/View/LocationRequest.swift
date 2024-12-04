//
//  LocationRequest.swift
//  Project Cars22
//
//  Created by Abderrahmen on 20/11/2024.
//

import SwiftUI

struct LocationRequest: View {
    @ObservedObject private var viewModel = ViewModel()
    @State private var id = UserDefaults.standard.string(forKey: "userId") ?? "Guest"

    var body: some View {
        ZStack {
            Color(.systemBlue).ignoresSafeArea()
            VStack {
                Image (systemName:"paperplane.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200,height: 200)
                    .foregroundColor(.white)
                    .padding(.bottom, 32)
                Text ("Would you like explore places nearby?")
                    .font(.system(size: 28,weight: .semibold))
                    .multilineTextAlignment(.center)
                    .padding()
                Text ("Start Sharing Your Location With Us")
                    .multilineTextAlignment(.center)
                    .frame(width: 140)
                    .padding()
                
                Spacer()
                VStack {
                    Button {
                        LocationManager.shared.requestLocation()
                        if let userLocation = LocationManager.shared.userlocation {

                            let latitude = userLocation.coordinate.latitude
                            let longitude = userLocation.coordinate.longitude
                            let locationString = "Latitude: \(latitude), Longitude: \(longitude)"
                          /*  viewModel.updateuser(id: id, location: locationString) {
                                success in
                                DispatchQueue.main.async {
                                    if success {
                                        print("User fetched successfully")
                                    } else {
                                        print("Failed to fetch user")
                                    }
                                }
                            }*/
                        }else {
                            print("User location is unavailable")
                        }
                      
                    } label: {
                        Text ("Allow location")
                            .padding()
                            .font(.headline)
                            .foregroundColor (Color(.systemBlue))
                            .frame(width: UIScreen.main.bounds.width)
                            .padding(.horizontal,-32)
                            .background(Color.white)
                            .clipShape(Capsule())
                            .padding()
                        
                        
                        
                    }
                    Button {
                        print ("Dismise")
                    } label: {
                        Text ("Maybe later")
                            .padding()
                            .font(.headline)
                            .foregroundColor (.white)
                    }
                }
            }
            .foregroundColor(.white)
        }
    }
}

#Preview {
    LocationRequest()
}
