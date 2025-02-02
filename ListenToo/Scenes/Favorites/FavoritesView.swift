//
//  FavoriteView.swift
//  App iOS
//
//  Created by Quentin Varlet on 02/03/2023.
//

import Domain
import SwiftUI

struct FavoritesView: View {

    // MARK: Properties

    @ObservedObject private var viewModel = FavoriteViewModel()

    // MARK: View

    var body: some View {
        NavigationView {
            List {
                if viewModel.favoriteList != [] {
                    Section(header: Text("Liste des favoris")) {
                        ForEach(viewModel.favoriteList ?? [], id: \.self) { movie in
                            NavigationLink {
                                MovieDetailView(viewModel: MovieDetailsViewModel(movie: movie))
                            } label: {
                                MovieRow(movie: movie)
                            }
                        }
                    }
                } else {
                    Section(header: Text("Aucun favoris")) {
                        ForEach(Movie.dummies, id: \.self) { movie in
                            MovieRow(movie: movie)
                                .redacted(reason: .placeholder)
                        }
                    }
                }
            }
            .navigationTitle(Tabs.favorites.title)
        }
        .onAppear {
            Task { try await viewModel.getMovies() }
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
