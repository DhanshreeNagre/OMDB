//
//  OmdbSearchController.swift
//  OMDB-Demo
//
//  Created by Dhanshree Nagre on 14/01/20.
//  Copyright © 2020 Dhanshree Nagre. All rights reserved.
//

import UIKit

class OmdbSearchController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .navigationBlue
        searchButton.layer.cornerRadius = 3
        searchButton.clipsToBounds = true
        searchTextField.attributedPlaceholder = NSAttributedString(string: "Search Movie",
                                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.4)])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    // MARK: Actions

    @IBAction func searchMovieTapped(_ sender: Any) {
        // Check for the movie name
        guard let searchText = searchTextField.text else {
            showErrorAlert()
            return
        }

        if searchText == "" {
            showErrorAlert()
        } else {
            // TODO: Perform movie search

            let searchRequest = SearchMovieRequest()

            searchRequest.searchForMovie(searchText: searchText, completion: { result in
                switch result {
                    case .success(let searchResults):
                        // Populate data on next view controller
                        self.showOmdbMoviesListController(searchResults)
                        break
                    case .failure( _):
                        // Show Error alert
                        DispatchQueue.main.async {
                            self.showSearchFailureErrorAlert()
                        }
                        break
                }
            })
        }
    }

    func showOmdbMoviesListController(_ results: Search) {
        DispatchQueue.main.async {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let omdbMoviesListController = storyBoard.instantiateViewController(withIdentifier: "OmdbMoviesListControllerID") as! OmdbMoviesListController
            omdbMoviesListController.movies = results.search
            omdbMoviesListController.searchText = self.searchTextField.text ?? ""
            self.navigationController?.pushViewController(omdbMoviesListController, animated: true)
        }
    }

    // MARK: Alerts

    func showErrorAlert() {
        let alert = UIAlertController(title: "Empty Text.", message: "Please enter the search text to search the movie.", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

        self.present(alert, animated: true)
    }

    func showSearchFailureErrorAlert() {
        let alert = UIAlertController(title: "Network failure.", message: "Unable to load the movies. Please try again.", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
}

