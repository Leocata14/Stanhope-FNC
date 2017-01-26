//
//  MatchCell.swift
//  Stanhope FNC
//
//  Created by Jason Leocata on 21/1/17.
//  Copyright © 2017 Jason Leocata. All rights reserved.
//

import UIKit

class MatchCell: UITableViewCell {
    
    var match: Match!
    
    @IBOutlet weak var stanhopeScoreLabel: UILabel!
    @IBOutlet weak var oppositionScoreLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    func configureMatchCell(match: Match){
        self.match = match
        self.stanhopeScoreLabel.text = match.stanhopeScore
        self.oppositionScoreLabel.text = match.oppositionScore
        self.gradeLabel.text = match.grade
        
        
        if Int(match.stanhopeScore!)! > Int(match.oppositionScore!)! {
            stanhopeScoreLabel.textColor = COLOUR_GREEN
        } else if match.stanhopeScore == match.oppositionScore {
            stanhopeScoreLabel.textColor = COLOUR_CHARCOAL
            oppositionScoreLabel.textColor = COLOUR_CHARCOAL
        } else {
            oppositionScoreLabel.textColor = COLOUR_GREEN
        }
        

        
    }
    
}
