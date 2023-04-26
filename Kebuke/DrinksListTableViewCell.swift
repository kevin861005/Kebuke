//
//  DrinksListTableViewCell.swift
//  Kebuke
//
//  Created by NAI LUN CHEN on 2023/4/26.
//

import UIKit

class DrinksListTableViewCell: UITableViewCell {

    @IBOutlet weak var drinkNameLabel: UILabel!
    @IBOutlet weak var drinkDescriptionLabel: UILabel!
    @IBOutlet weak var drinkImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
