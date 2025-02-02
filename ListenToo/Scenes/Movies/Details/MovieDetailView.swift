//
//  MovieDetailView.swift
//  App iOS
//
//  Created by Quentin Varlet on 02/03/2023.
//

import Domain
import Utils
import SwiftUI

struct MovieDetailView: View {

    // MARK: Properties

    @ObservedObject var viewModel: MovieDetailsViewModel

    let spacing: CGFloat = 10

    // MARK: View

    var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            Text("Episode n°\(viewModel.movie?.episodeId ?? 0)")
                .font(.title)
            Text(viewModel.movie?.openingCrawl.removingCharacters(from: .newlines) ?? "")
                .font(.subheadline)
            Divider()
                .padding(.vertical, 12)
            Text("Date de création : \(viewModel.movie?.releaseDate ?? "")")
                .font(.title2)
            Text("Editer en : \(viewModel.movie?.edited ?? "")")
            Spacer()
        }
        .padding(12)
        .frame(maxHeight: .infinity, alignment: .bottom)
        .navigationTitle(viewModel.movie?.title ?? "")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(viewModel: MovieDetailsViewModel(movie: Movie.dummy))
    }
}
