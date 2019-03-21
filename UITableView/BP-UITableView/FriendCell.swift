//
//  FriendCell.swift
//  BP-UITableView
//
//  Created by Ryan Jin on 2019/3/21.
//  Copyright © 2019 Perfect365, Inc. All rights reserved.
//

import UIKit

class FriendCell: UITableViewCell {

    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var item: Friend? {
        
        didSet {
            guard let item = item else {
                return
            }
            if let pictureUrl = item.pictureUrl {
                pictureImageView?.image = UIImage(named: pictureUrl)
            }
            nameLabel?.text = item.name
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        pictureImageView?.layer.cornerRadius = 40
        pictureImageView?.clipsToBounds = true
        pictureImageView?.contentMode = .scaleAspectFit
        pictureImageView?.backgroundColor = UIColor.lightGray
    }

    static var identifier: String {
        return String(describing: self)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        pictureImageView?.image = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
