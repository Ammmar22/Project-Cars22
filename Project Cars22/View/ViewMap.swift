//
//  ViewMap.swift
//  Project Cars22
//
//  Created by Abderrahmen on 24/11/2024.
//

import SwiftUI
import MapKit
struct ViewMap: View {
    @State private var mechanics: [Mechanic] = [
        Mechanic(name: "Mechanic 1", coordinate: CLLocationCoordinate2D(latitude: 36.8065, longitude: 10.1815),photo: "PhotoCar"),
        Mechanic(name: "Mechanic 2", coordinate: CLLocationCoordinate2D(latitude: 36.8105, longitude: 10.1900),photo: "PhotoCar")
    ]
    @State private var selectedMechanic: Mechanic? = nil
    @State private var SearchText : String = ""
    @State private var ShowSearchText : Bool = false
    @State private var SearchResult : [MKMapItem] = []
    @State private var mapCenter: CLLocationCoordinate2D = .myLocation
    @ObservedObject private var locationManager = LocationManager2.shared
    @State private var route: MKRoute? = nil

    @Namespace private var locationSpace
    @State private var cameraPosition : MapCameraPosition = .region(.myRegion)
    var body: some View {
        NavigationStack {
            Map(position: $cameraPosition){
                ForEach(mechanics) { mechanic in
                    Annotation(mechanic.name, coordinate: mechanic.coordinate) {
                        ZStack {
                            Image(systemName: "wrench")
                                .font(.title3)
                                .foregroundColor(.blue)
                        }
                        .onTapGesture {
                            selectedMechanic = mechanic
                            calculateRoute(to: mechanic.coordinate)

                        }
                        
                    }
                }

                
                ForEach(SearchResult, id: \.self){ mapItem in
                    let placemark = mapItem.placemark
                    Marker(placemark.name ?? "Place", coordinate: placemark.coordinate)
                }
                if let route = route {
                                  MapPolyline(route.polyline)
                                      .stroke(Color.blue, lineWidth: 3)
                              }
              
                UserAnnotation()
            }
            .overlay(alignment : .bottomTrailing) {
                VStack(spacing: 15) {
                    MapCompass(scope: locationSpace)
                    MapPitchToggle(scope: locationSpace)
                    MapUserLocationButton(scope: locationSpace)
                }
                .buttonBorderShape(.circle)
                .padding()
                
            }
            .mapScope(locationSpace)
            .navigationTitle("Map")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $SearchText, isPresented: $ShowSearchText)
            .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
            .sheet(item: $selectedMechanic) { mechanic in
                           MechanicDetailView(mechanic: mechanic, userLocation: locationManager.userLocation)
                       }

        }
        .onSubmit(of: .search) {
            Task {
                guard !SearchText.isEmpty else {return}
                    await searchPlaces()
            }
        }       

        
    }
    
    func searchPlaces() async {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = SearchText
        request.region = .myRegion
        
        let results = try? await MKLocalSearch(request: request).start()
        SearchResult = results?.mapItems ?? []
    }
    
    func calculateRoute(to destination: CLLocationCoordinate2D) {
          guard let userLocation = locationManager.userLocation else {
              print("there is a probleme")
              return }
        print("no probleme")
        
        

          let sourcePlacemark = MKPlacemark(coordinate: userLocation)
          let destinationPlacemark = MKPlacemark(coordinate: destination)
          
          let request = MKDirections.Request()
          request.source = MKMapItem(placemark: sourcePlacemark)
          request.destination = MKMapItem(placemark: destinationPlacemark)
          request.transportType = .automobile

          let directions = MKDirections(request: request)
          directions.calculate { response, error in
              if let route = response?.routes.first {
                  print("kakak")
                  self.route = route
              }
              if let error = error {
                     print("Error calculating route: \(error.localizedDescription)")
                     return
                 }
          }
      }
}

#Preview {
    ViewMap()
}


extension CLLocationCoordinate2D{
    static var myLocation :CLLocationCoordinate2D {
        return .init(latitude:36.8065, longitude : 10.1815)
    }
}


extension MKCoordinateRegion{
    static var myRegion:MKCoordinateRegion {
        return .init(center: .myLocation, latitudinalMeters: 10000, longitudinalMeters: 10000)
    }
}
