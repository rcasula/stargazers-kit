//
//  ContentView.swift
//  StargazersExample
//
//  Created by Roberto Casula on 16/03/22.
//

import StargazersKit
import SwiftUI

struct ContentView: View {

    @State var stargazers: [Stargazer] = []
    @State var error: String? = nil

    var body: some View {
        VStack {
            if let error = error {
                Text(error)
            } else {
                List {
                    ForEach(self.stargazers, id: \.id) { stargazer in
                        HStack {
                            AsyncImage(
                                url: .init(string: stargazer.avatarUrl),
                                content: { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 65, height: 65, alignment: .center)
                                        .clipShape(Circle())
                                },
                                placeholder: {
                                    Color.gray
                                        .frame(width: 65, height: 65, alignment: .center)
                                        .clipShape(Circle())
                                }
                            )

                            Text(stargazer.login)
                        }
                    }
                }
            }
        }
        .task(priority: .userInitiated) {
            do {
                let result = try await fetch()
                self.stargazers = result
            } catch let error {
                self.error = error.localizedDescription
            }

        }
    }

    init(stargazers: [Stargazer] = [], error: String? = nil) {
        self.stargazers = stargazers
        self.error = error
    }

    func fetch() async throws -> [Stargazer] {
        try await withCheckedThrowingContinuation { continuation in
            StargazersKit.shared.stargazers(for: "GRDB.swift", owner: "groue") { result in
                continuation.resume(with: result)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            stargazers: [

            ],
            error: nil
        )
    }
}
