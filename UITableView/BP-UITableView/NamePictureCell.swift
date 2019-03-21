//
//  NamePictureCell.swift
//  BP-UITableView
//
//  Created by Ryan Jin on 2019/3/21.
//  Copyright © 2019 Perfect365, Inc. All rights reserved.
//

import UIKit

class NamePictureCell: UITableViewCell {

    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var item: ProfileViewModelItem? {
        
        didSet {
            guard let item = item as? ProfileViewModelNamePictureItem else {
                return
            }
            nameLabel?.text = item.name
            pictureImageView?.image = UIImage(named: item.pictureUrl)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        pictureImageView?.layer.cornerRadius = 50
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
