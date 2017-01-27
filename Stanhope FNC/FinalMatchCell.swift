//
//  FinalMatchCell.swift
//  Stanhope FNC
//
//  Created by Jason Leocata on 27/1/17.
//  Copyright © 2017 Jason Leocata. All rights reserved.
//

import UIKit

class FinalMatchCell: UITableViewCell {
    
    var finalMatch: FinalMatch!

    @IBOutlet weak var stanhopeImageView: UIImageView!
    @IBOutlet weak var oppositionImageView: UIImageView!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var stanhopeScoreLabel: UILabel!
    @IBOutlet weak var oppositionScoreLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureFinalCell(final: FinalMatch) {
        self.finalMatch = final
        self.statusLabel.text = final.status.uppercased()
        self.stanhopeImageView.image = UIImage(named: "Stanhope")
        self.oppositionImageView.image = UIImage(named: "\(final.opposition)")
        
        //let finalDate = roundDateStringToNSDate(date: final.date)
        
        self.locationLabel.text = "@ \(final.playedAt)"
        
        if final.status == "Upcoming" {
            statusLabel.textColor = COLOUR_ORANGE
        } else if final.status == "Complete" {
            statusLabel.textColor = COLOUR_GREEN
        }
        
    }

}
