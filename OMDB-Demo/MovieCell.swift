//
//  MovieCell.swift
//  OMDB-Demo
//
//  Created by Dhanshree Nagre on 15/01/20.
//  Copyright © 2020 Dhanshree Nagre. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var cardContainer: UIView!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var movieYearLabel: UILabel!

    func updateCell() {

    }

    func drawCard() {
        moviePosterImageView?.contentMode = .scaleAspectFill
        moviePosterImageView.layer.cornerRadius = 3.0
        
        cardContainer.backgroundColor = .white
        cardContainer.layer.cornerRadius = 3.0
    }
}
