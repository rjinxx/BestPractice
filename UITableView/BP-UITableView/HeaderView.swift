//
//  HeaderView.swift
//  BP-UITableView
//
//  Created by Ryan Jin on 2019/3/21.
//  Copyright © 2019 Perfect365, Inc. All rights reserved.
//

import UIKit

protocol HeaderViewDelegate: class {
    func toggleSection(header: HeaderView, section: Int)
}

class HeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var arrowLabel: UILabel!
    
    weak var delegate: HeaderViewDelegate?

    var section: Int = 0

    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }

    var item: ProfileViewModelItem? {
        
        didSet {
            guard let item = item else {
                return
            }
            titleLabel?.text = item.sectionTitle
            setCollapsed(collapsed: item.isCollapsed)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapHeader)))
    }

    @objc private func didTapHeader() {
        delegate?.toggleSection(header: self, section: section)
    }

    func setCollapsed(collapsed: Bool) {
        arrowLabel?.rotate(collapsed ? 0.0 : .pi)
    }
}

extension UIView {
    
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        self.layer.add(animation, forKey: nil)
    }
}
