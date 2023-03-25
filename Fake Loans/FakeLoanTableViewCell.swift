//
//  FakeLoanTableViewCell.swift
//  Fake Loans
//
//  Created by Sorfian on 25/03/23.
//

import UIKit

class FakeLoanTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel:UILabel! {
        didSet {
            nameLabel.numberOfLines = 0
        }
    }
    @IBOutlet weak var countryLabel:UILabel! {
        didSet {
            countryLabel.numberOfLines = 0
        }
    }
    @IBOutlet weak var useLabel:UILabel! {
        didSet {
            useLabel.numberOfLines = 0
        }
    }
    @IBOutlet weak var amountLabel:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
