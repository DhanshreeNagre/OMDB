//
//  SearchMovieRequest.swift
//  OMDB-Demo
//
//  Created by Dhanshree Nagre on 14/01/20.
//  Copyright © 2020 Dhanshree Nagre. All rights reserved.
//

import Foundation

struct SearchMovieRequest {

    func searchForMovie(searchText: String, completion: @escaping(Result<Search, Error>) -> Void) {
        let urlString = "http://www.omdbapi.com/?apikey=d062a57d&s=\(searchText)"

        guard let movieURL = URL(string: urlString) else {
            return
        }

        let dataTask = URLSession.shared.dataTask(with: movieURL, completionHandler: { (data, response, error) -> Void in
            guard let data = data, error == nil, response != nil else {
                completion(.failure(error!))
                return
            }

            do {
                // Decode the json data.
                let decoder = JSONDecoder()
                let searchResults = try decoder.decode(Search.self, from: data)
                completion(.success(searchResults))
            } catch {
                completion(.failure(error))
            }
        })

        dataTask.resume()
    }
}
