//
//  MainView.swift
//  listen-too-ios
//
//  Created by Quentin Varlet on 19/12/2024.
//

import Domain
import SwiftUI
import Logger

@main
struct MainView: App {

    // MARK: Properties

    @StateObject private var movieDetailsViewModel = MovieDetailsViewModel(movie: Movie.dummy)

    let logger = Logger(category: "MainView")

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(movieDetailsViewModel)
                .onAppear {
                    logger.info("View Appear")
                }
        }
    }
}
