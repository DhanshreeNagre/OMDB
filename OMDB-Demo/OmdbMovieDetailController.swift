//
//  OmdbMovieDetailController.swift
//  OMDB-Demo
//
//  Created by Dhanshree Nagre on 15/01/20.
//  Copyright © 2020 Dhanshree Nagre. All rights reserved.
//

import UIKit

class OmdbMovieDetailController: UIViewController {

    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var directorNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var storyLineLabel: UILabel!

    @IBOutlet weak var detailsOverlay: UIView!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!

    var movieDetails: MovieDetails?


    override func viewDidLoad() {
        super.viewDidLoad()
        showMoviewDetails()
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

    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    // MARK: Methods
    func showMoviewDetails() {
        detailsOverlay.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        if let movieDetails = movieDetails {
            fetchMoviePoster(path: movieDetails.poster)
            let runtimeInHrs = minutesToHoursMinutes(minutes: movieDetails.runtime)
            titleLabel.text = movieDetails.title
            ratingLabel.text = "\(movieDetails.imdbRating)/10"
            detailLabel.text = "\(runtimeInHrs) | \(movieDetails.genre)"
            directorNameLabel.text = movieDetails.director
            releaseDateLabel.text = movieDetails.released
            storyLineLabel.text = movieDetails.plot
        }
    }


    func fetchMoviePoster(path: String) {
        if
            let posterURL = URL(string: path) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: posterURL) {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.moviePosterImageView?.image = image
                    }
                }
            }
        }
    }

    func minutesToHoursMinutes (minutes : String) -> String {
        let mins = Int(minutes.replacingOccurrences(of: " min", with: ""))!
        let hrs = mins / 60
        let leftMins = (mins % 60)
        return "\(hrs)h \(leftMins)min"
    }
}
