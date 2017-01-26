//
//  RoundCell.swift
//  Stanhope FNC
//
//  Created by Jason Leocata on 19/1/17.
//  Copyright © 2017 Jason Leocata. All rights reserved.
//

import UIKit

class RoundCell: UITableViewCell {
    
    var round: Round!
    
    @IBOutlet weak var stanImgView: UIImageView!
    @IBOutlet weak var oppImgView: UIImageView!
    @IBOutlet weak var roundStatus: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var playedAtLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func configureRoundCell(round: Round){
        self.round = round
        self.roundStatus.text = round.status!.uppercased()
        self.stanImgView.image = UIImage(named: "Stanhope")
        self.oppImgView.image = UIImage(named: "\(round.opposition!)")
        
        let roundDate = roundDateStringToNSDate(date: round.date!)
    
        self.dateLabel.text = "Round \(round.round!) - \(roundDate.fullMonth + " " + roundDate.day)"
        self.playedAtLabel.text = round.playedAt
        
        if round.status == "Upcoming" {
            roundStatus.textColor = COLOUR_ORANGE
        } else if round.status == "Complete" {
            roundStatus.textColor = COLOUR_GREEN
        }
    }
    
        
        
        
}
