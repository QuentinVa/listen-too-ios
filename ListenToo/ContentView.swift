//
//  ContentView.swift
//  listen-too-ios
//
//  Created by Quentin Varlet on 19/12/2024.
//

import Utils
import SwiftUI

public enum Tabs: Hashable {

    case films
    case favorites
    case components

    internal var title: String {
        switch self {
        case .films:
            return "Films"
        case .favorites:
            return "Favorites"
        case .components:
            return "Composants"
        }
    }
}

struct ContentView: View {

    @State internal var tabSelection: String = Tabs.films.title

    internal var body: some View {
        TabView {
            MoviesView()
                .tabItem {
                    Label(Tabs.films.title, systemImage: "film.stack")
                }

            FavoritesView()
                .tabItem {
                    Label(Tabs.favorites.title, systemImage: "star.fill")
                }

            ComponentsView()
                .tabItem {
                    Label(Tabs.components.title, systemImage: "list.number")
                }
        }
        .onOpenURL { url in
            guard let tabIdentifier = url.tabIdentifier else {
                return
            }
            tabSelection = tabIdentifier.title
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
