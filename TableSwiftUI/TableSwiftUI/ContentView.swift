//
//  ContentView.swift
//  TableSwiftUI
//
//  Created by Sigmon, Lewis P on 4/12/23.
//

import SwiftUI
import MapKit

let data = [
    Item(name: "Brew and Brew", type: "Coffee & Food", desc: "Not only brews coffee but beer aswell, hence the name.", lat: 30.264614946562336, long: -97.73305951483454, imageName: "brewbrew"),
    Item(name: "Revival Coffee", type: "Coffee", desc: "Latina owned coffee shop recognized for its pink design. Includes adjoining food truck courtyard and hammock lounge.", lat: 30.264474980448913, long: -97.72774740134187, imageName: "revivalcoffee"),
    Item(name: "Easy Tiger", type: "Coffee & Food", desc: "Coffee shop that also includes outdoor area. Has a dog friendly park and outdoor games such as ping pong, corn hole and more.", lat: 30.26426584703827, long: -97.72703281668487, imageName: "easytiger"),
    Item(name: "Royal Blue Grocery", type: "Coffee & Food", desc: "This coffee shop is also a grocery store. Open till late at night.", lat: 30.26507731364953, long: -97.74207188969949, imageName: "royalblue"),
    Item(name: "Lazarus", type: "Coffee & Food", desc: "Cozy brewery for house beers, plus root beer, kombucha, espresso & house tacos.", lat: 30.261841717009492, long: -97.72202395901338, imageName: "lazarus")
   
]

struct Item: Identifiable {
       let id = UUID()
       let name: String
       let type: String
       let desc: String
       let lat: Double
       let long: Double
       let imageName: String
   }


struct ContentView: View {
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 30.295190, longitude: -97.726220), span: MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07))
    var body: some View {
        NavigationView {
            VStack {
                List(data, id: \.name) { item in
                    NavigationLink(destination: DetailView(item: item)) {
                        HStack {
                            Image(item.imageName)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(10)
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                                    .font(.subheadline)
                            }
                        }
                    }
                }
                Map(coordinateRegion: $region, annotationItems: data) { item in
                                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                                    Image(systemName: "mappin.circle.fill")
                                        .foregroundColor(.red)
                                        .font(.title)
                                        .overlay(
                                            Text(item.name)
                                                .font(.subheadline)
                                                .foregroundColor(.black)
                                                .fixedSize(horizontal: true, vertical: false)
                                                .offset(y: 25)
                                        )
                                }
                            }
                            .frame(height: 300)
                            .padding(.bottom, -30)
                
                .listStyle(PlainListStyle())
                        .navigationTitle("512 Coffee")
            }
        }
    }
}


struct DetailView: View {
    
    @State private var region: MKCoordinateRegion
          
          init(item: Item) {
              self.item = item
              _region = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long), span: MKCoordinateSpan(latitudeDelta: 0.20, longitudeDelta: 0.20)))
          }
    
    let item: Item
            
    var body: some View {
        VStack {
            Image(item.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 200)
            Text("Type: \(item.type)")
                .font(.subheadline)
            Text("Description: \(item.desc)")
                .font(.subheadline)
                .padding(10)
                }
                 .navigationTitle(item.name)
                 Spacer()
        Map(coordinateRegion: $region, annotationItems: [item]) { item in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                    Image(systemName: "mappin.circle.fill")
                        .foregroundColor(.red)
                        .font(.title)
                        .overlay(
                            Text(item.name)
                                .font(.subheadline)
                                .foregroundColor(.black)
                                .fixedSize(horizontal: true, vertical: false)
                                .offset(y: 25)
                        )
                }
            }
                .frame(height: 300)
                //.padding(.bottom, -30)
     }
  }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
