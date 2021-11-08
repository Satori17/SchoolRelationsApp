//
//  PupilTableViewCell.swift
//  SchoolRelationsApp
//
//  Created by Saba Khitaridze on 07.11.21.
//

import UIKit

class pupilCell: UITableViewCell {

    @IBOutlet weak var pupilNameLabel: UILabel!
    @IBOutlet weak var pupilSurnameLabel: UILabel!
    @IBOutlet weak var pupilGenderLabel: UILabel!
    @IBOutlet weak var pupilClassLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
