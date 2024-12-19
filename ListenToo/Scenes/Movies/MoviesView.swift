//
//  MoviesView.swift
//  App iOS
//
//  Created by Quentin Varlet on 28/02/2023.
//

import Domain
import SwiftUI

struct MoviesView: View {

    // MARK: Properties

    @EnvironmentObject private var detailsMovieModel: MovieDetailsViewModel

    @ObservedObject private var viewModel = MoviesViewModel()

    @State private var selection: Movie?

    // MARK: View

    var body: some View {
        // swiftlint:disable:next closure_body_length
        NavigationView {
            List {
                Section(header: Text("Liste de films")) {
                    ForEach(viewModel.sortedMovies, id: \.self) { movie in
                        NavigationLink(tag: movie, selection: $selection) {
                            MovieDetailView(viewModel: MovieDetailsViewModel(movie: movie))
                        } label: {
                            HStack {
                                Text("\(movie.episodeId).")
                                Text(movie.title)
                                Spacer()

                                Button(action: {
                                    if self.viewModel.contains(movie) {
                                        self.viewModel.remove(movie)
                                    } else {
                                        self.viewModel.add(movie)
                                    }
                                }) {
                                    Image(systemName: self.viewModel.contains(movie) ? "star.fill" : "star")
                                        .foregroundColor(self.viewModel.contains(movie) ? .green : .red)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .tag(movie)
                    }
                }
                // swiftlint:disable:next empty_collection_literal
                if viewModel.sortedMovies == [] {
                    ForEach(Movie.dummies, id: \.self) { movie in
                        MovieRow(movie: movie)
                            .redacted(reason: .placeholder)
                    }
                }
            }
            .navigationTitle(Tabs.films.title)
        }
        .onAppear {
            Task {
                try await viewModel.getMovies()
            }
        }
        .onReceive(detailsMovieModel.$episodeId, perform: { _ in
            Task {
                try await detailsMovieModel.getEpisode()
            }
        })
        .onReceive(detailsMovieModel.$movie) { movie in
            guard let movie else { return }
            selection = movie
        }
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
            .environmentObject(
                MovieDetailsViewModel(movie: Movie.dummy)
            )
    }
}
