//
//  movieCell.swift
//  flixClone
//
//  Created by Kyle Mamiit (New) on 10/5/18.
//  Copyright © 2018 Kyle Mamiit. All rights reserved.
//

import UIKit

class movieCell: UITableViewCell {

    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}