//
//  CustomCell.swift
//  BP-UITableView
//
//  Created by Ryan Jin on 2019/3/24.
//  Copyright © 2019 Perfect365, Inc. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    var item: ViewModelItem? {
        didSet {
            titleLabel?.text = item?.title
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        accessoryType = selected ? .checkmark : .none
    }

    static var identifier: String {
        return String(describing: self)
    }
}
