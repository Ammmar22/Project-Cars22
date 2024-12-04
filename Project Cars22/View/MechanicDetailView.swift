//
//  MechanicDetailView.swift
//  Project Cars22
//
//  Created by Abderrahmen on 24/11/2024.
//

import SwiftUI
import MapKit

struct MechanicDetailView: View {
    let mechanic: Mechanic
       let userLocation: CLLocationCoordinate2D?

       var distance: String {
           guard let userLocation = userLocation else { return "Unknown distance" }
           let mechanicLocation = CLLocation(latitude: mechanic.coordinate.latitude, longitude: mechanic.coordinate.longitude)
           let userCLLocation = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
           let distanceInMeters = userCLLocation.distance(from: mechanicLocation)
           return String(format: "%.2f km", distanceInMeters / 1000) // Convert to km
       }

       var body: some View {
           VStack(spacing: 20) {
               Image(mechanic.photo)
                   .resizable()
                   .scaledToFit()
                   .frame(width: 150, height: 150)
                   .clipShape(Circle())
                   .shadow(radius: 10)

               Text(mechanic.name)
                   .font(.title)
                   .fontWeight(.bold)

               Text("Distance: \(distance)")
                   .font(.subheadline)

               Spacer()
           }
           .padding()
           .presentationDetents([.medium, .large])
       }
   }

#Preview {
    ContentView()
}
