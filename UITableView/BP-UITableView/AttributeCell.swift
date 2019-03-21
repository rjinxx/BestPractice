//
//  AttributeCell.swift
//  BP-UITableView
//
//  Created by Ryan Jin on 2019/3/21.
//  Copyright © 2019 Perfect365, Inc. All rights reserved.
//

import UIKit

class AttributeCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    var item: Attribute?  {
        
        didSet {
            titleLabel?.text = item?.key
            valueLabel?.text = item?.value
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    static var identifier: String {
        return String(describing: self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
