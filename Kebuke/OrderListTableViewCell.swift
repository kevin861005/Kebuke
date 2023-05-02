//
//  OrderListTableViewCell.swift
//  Kebuke
//
//  Created by NAI LUN CHEN on 2023/4/29.
//

import UIKit

class OrderListTableViewCell: UITableViewCell {

    @IBOutlet weak var mediumPriceLabel: UILabel!
    @IBOutlet weak var largePriceLabel: UILabel!
    @IBOutlet weak var drinkNameLabel: UILabel!
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
