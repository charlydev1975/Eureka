//
//  ContentView.swift
//  Eureka
//
//  Created by Carlos Caraccia on 9/21/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State var photos = [Photo]()
    @State var counter = 0
    @State private var isPresented = false
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                        ForEach(photos) { _ in
                            NavigationLink(destination:PhotoView(), isActive: $isPresented) {
                                PhotoView()
                            }
                        }
                    }
                    .padding()
                }
                Spacer()
                Button("Take picture") {
                    let photo = Photo(id: self.counter)
                    photos.append(photo)
                    counter += 1
                }
            }
        }
    }
}

// View (we will initialize the view with the model that we nave
struct PhotoView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill()
            .foregroundColor(.blue)
            .aspectRatio(4/3, contentMode: .fit)
    }
}

// Model
struct Photo:Identifiable {
    
    let id:Int
    var image:Data?
    var latiture:String?
    var longitude:String?
    
    init(id:Int) {
        self.id = id
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
