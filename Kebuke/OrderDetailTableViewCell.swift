//
//  OrderDetailTableViewCell.swift
//  Kebuke
//
//  Created by NAI LUN CHEN on 2023/5/1.
//

import UIKit

class OrderDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var drinkInfoLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var buyerNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
