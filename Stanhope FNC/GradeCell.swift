//
//  GradeCell.swift
//  Stanhope FNC
//
//  Created by Jason Leocata on 21/1/17.
//  Copyright © 2017 Jason Leocata. All rights reserved.
//

import UIKit

class GradeCell: UITableViewCell {
    
    var grade: Grade!
    
    @IBOutlet weak var gradeName: UILabel!
    @IBOutlet weak var gradeShortName: UILabel!
    @IBOutlet weak var shortNameBGView: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureGradeCell(grade: Grade) {
        self.grade = grade
        self.gradeName.text = grade.name
        self.gradeShortName.text = grade.shortName
        
        self.shortNameBGView.layer.cornerRadius = self.shortNameBGView.frame.size.width / 2
        self.shortNameBGView.clipsToBounds = true
    }

}
