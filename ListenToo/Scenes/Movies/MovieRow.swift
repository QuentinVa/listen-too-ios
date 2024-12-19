//
//  MovieRow.swift
//  App iOS
//
//  Created by Quentin Varlet on 02/03/2023.
//

import Domain
import SwiftUI

struct MovieRow: View {

    // MARK: Properties

    var movie: Movie

    // MARK: View

    var body: some View {
        HStack {
            Text("\(movie.episodeId).")
            Text(movie.title)
            Spacer()
        }
    }
}

struct MovieRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MovieRow(movie: Movie.dummy)
            MovieRow(movie: Movie.dummy2)
        }
        // swiftlint:disable:next no_magic_numbers
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
