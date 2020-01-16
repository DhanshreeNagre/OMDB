//
//  OmdbMoviesListController.swift
//  OMDB-Demo
//
//  Created by Dhanshree Nagre on 15/01/20.
//  Copyright © 2020 Dhanshree Nagre. All rights reserved.
//

import UIKit

class OmdbMoviesListController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var movieListTableView: UITableView!
    var movies: [Movie] = []
    var searchText: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigatioonBar()
    }

    func setupNavigatioonBar() {
        let button = UIBarButtonItem(image: UIImage(named: "backImage"), style: .plain, target: self, action: #selector(backTapped))
        self.navigationItem.leftBarButtonItem  = button
        self.navigationItem.title = searchText
        self.navigationController?.navigationBar.barTintColor = .navigationBlue
        self.navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }

    @objc func backTapped() {
        navigationController?.popViewController(animated: true)
    }

    // MARK: UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCellID", for: indexPath) as! MovieCell
        let currentMovie = movies[indexPath.row]

        //Make cell selection invisible
        cell.selectionStyle = .none
        cell.drawCard()

        cell.titleLabel.text = currentMovie.title
        cell.movieYearLabel.text = currentMovie.year

        if
            let posterURL = URL(string: currentMovie.poster) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: posterURL) {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.moviePosterImageView?.image = image
                        cell.setNeedsLayout()
                    }
                }
            }
        }
        return cell
    }

    // MARK: UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = movies[indexPath.row]

        let detailsRequest = MovieDetailsRequest()

        detailsRequest.getMovieDetails(searchText: selectedMovie.imdbID, completion: { result in
            switch result {
            case .success(let searchResults):
                // Populate data on next view controller
                self.showOmdbMovieDetailController(searchResults)
            case .failure( _):
                // Show Error alert
                DispatchQueue.main.async {
                  self.showUnableToLoadAlert()
                }
            }
        })
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    // MARK: User Defined functions

    func showOmdbMovieDetailController(_ results: MovieDetails) {
        DispatchQueue.main.async {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let omdbMovieDetailController = storyBoard.instantiateViewController(withIdentifier: "OmdbMovieDetailControllerID") as! OmdbMovieDetailController
            omdbMovieDetailController.movieDetails = results
            self.navigationController?.pushViewController(omdbMovieDetailController, animated: true)
        }
    }

    // MARK: Alerts

    func showUnableToLoadAlert() {
        let alert = UIAlertController(title: "Unknown Failure.", message: "Unable to load the movie details. Please try again.", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }

}
