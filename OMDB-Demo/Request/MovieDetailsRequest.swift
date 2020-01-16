//
//  MovieDetailsRequest.swift
//  OMDB-Demo
//
//  Created by Dhanshree Nagre on 14/01/20.
//  Copyright © 2020 Dhanshree Nagre. All rights reserved.
//

import Foundation

struct MovieDetailsRequest {

    func getMovieDetails(searchText: String, completion: @escaping(Result<MovieDetails, Error>) -> Void) {
        let urlString = "http://www.omdbapi.com/?apikey=d062a57d&i=\(searchText)"

        guard let movieDetailsURL = URL(string: urlString) else {
            return
        }

        let dataTask = URLSession.shared.dataTask(with: movieDetailsURL, completionHandler: { (data, response, error) -> Void in
            guard let data = data, error == nil, response != nil else {
                completion(.failure(error!))
                return
            }

            do {
                // Decode the json data.
                let decoder = JSONDecoder()
                let searchResults = try decoder.decode(MovieDetails.self, from: data)
                completion(.success(searchResults))
            } catch {
                completion(.failure(error))
            }
        })

        dataTask.resume()
    }
}
