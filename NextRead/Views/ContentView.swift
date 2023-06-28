//
//  ContentView.swift
//  NextRead
//
//  Created by Michael Schmidt on 5/19/23.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext


    var body: some View {
        TabView {
            NavigationView {
                HomeView()

                    .navigationTitle("Next Read")
            }
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            NavigationView {
                SearchView()

                    .navigationTitle("Search")
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
            NavigationView {
                MyListView()
                    .navigationTitle("My List")
            }
            .tabItem {
                Image(systemName: "list.bullet")
                Text("My List")
            }

            //
            //                     OtherView()
            //                         .tabItem {
            //                             Image(systemName: "ellipsis")
            //                             Text("Other")
            //                         }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
