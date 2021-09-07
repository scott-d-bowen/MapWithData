//
//  ContentView.swift
//  MapWithData
//
//  Created by Scott D. Bowen on 7/9/21.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var region = MKCoordinateRegion(center:
                                CLLocationCoordinate2D(latitude: -35.45285, longitude: +149.10719),
                                // span: MKCoordinateSpan(latitudeDelta: 0.125, longitudeDelta: 0.125),
                                latitudinalMeters: 12500,
                                longitudinalMeters: 12500
    )
    
    var locations: [Location] = [ ]
    
    init() {
        generateRandomLocations(locations: &locations)
    }
    
    var body: some View {
        
        Map(coordinateRegion: $region,
            interactionModes: .all,
            showsUserLocation: false,
            userTrackingMode: .none,
            annotationItems: locations) {
                MapAnnotation(coordinate: $0.coordinate) {
                    Circle()
                        .fill(Color.secondary)
                        .frame(width: 7, height: 7)
                        .drawingGroup(opaque: true, colorMode: .extendedLinear)
                }
        }
        .frame(width: 1536, height: 960)
        // .drawingGroup()
    }
}

func randomNearbyLocation() -> Location {
    let name = "Random Location"
    let randomLatitude = Float64.random(in: (-35.510)...(-35.319))
    let randomLongitude = Float64.random(in: 148.878...149.345)
    
    let randomLocation = Location(name: name, coordinate: CLLocationCoordinate2D(latitude: randomLatitude, longitude: randomLongitude))
    
    return randomLocation
}
func generateRandomLocations(locations: inout [Location]) {
    for _ in 0..<256 {
        locations.append(randomNearbyLocation() )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}
