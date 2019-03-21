//
//  ProfileViewModel.swift
//  BP-UITableView
//
//  Created by Ryan Jin on 2019/3/21.
//  Copyright © 2019 Perfect365, Inc. All rights reserved.
//

import UIKit

enum ProfileViewModelItemType {
    case nameAndPicture
    case about
    case email
    case friend
    case attribute
}

protocol ProfileViewModelItem {
    
    var type: ProfileViewModelItemType { get }
    var sectionTitle: String { get }
    var rowCount: Int { get }
    var isCollapsible: Bool { get }
    var isCollapsed: Bool { get set }
}

extension ProfileViewModelItem {
    
    var rowCount: Int {
        return 1
    }
    var isCollapsible: Bool {
        return true
    }
}

class ProfileViewModel: NSObject {
    
    var items = [ProfileViewModelItem]()
    var reloadSections: ((_ section: Int) -> Void)?

    override init() {
        
        super.init()
        
        guard let data = dataFromFile("ServerData"), let profile = Profile(data: data) else {
            return
        }
        
        if let name = profile.fullName, let pictureUrl = profile.pictureUrl {
            items.append(ProfileViewModelNamePictureItem(name: name, pictureUrl: pictureUrl))
        }
        
        if let about = profile.about {
            items.append(ProfileViewModelAboutItem(about: about))
        }
        
        if let email = profile.email {
            items.append(ProfileViewModelEmailItem(email: email))
        }
        
        let attributes = profile.profileAttributes
        if !attributes.isEmpty {
            items.append(ProfileViewModeAttributeItem(attributes: attributes))
        }
        
        let friends = profile.friends
        if !profile.friends.isEmpty {
            items.append(ProfileViewModeFriendsItem(friends: friends))
        }
    }
}

class ProfileViewModelNamePictureItem: ProfileViewModelItem {
    
    var type: ProfileViewModelItemType {
        return .nameAndPicture
    }
    var sectionTitle: String {
        return "Main Info"
    }
    var isCollapsed = true
    
    var name: String
    var pictureUrl: String
    
    init(name: String, pictureUrl: String) {
        self.name = name
        self.pictureUrl = pictureUrl
    }
}

class ProfileViewModelAboutItem: ProfileViewModelItem {
    
    var type: ProfileViewModelItemType {
        return .about
    }
    var sectionTitle: String {
        return "About"
    }
    var isCollapsed = true

    var about: String
    
    init(about: String) {
        self.about = about
    }
}

class ProfileViewModeFriendsItem: ProfileViewModelItem {
    
    var type: ProfileViewModelItemType {
        return .friend
    }
    var sectionTitle: String {
        return "Friends"
    }
    var rowCount: Int {
        return friends.count
    }
    var isCollapsed = true

    var friends: [Friend]
    
    init(friends: [Friend]) {
        self.friends = friends
    }
}

class ProfileViewModeAttributeItem: ProfileViewModelItem {
    
    var type: ProfileViewModelItemType {
        return .attribute
    }
    var sectionTitle: String {
        return "Attributes"
    }
    var rowCount: Int {
        return attributes.count
    }
    var isCollapsed = true

    var attributes: [Attribute]
    
    init(attributes: [Attribute]) {
        self.attributes = attributes
    }
}

class ProfileViewModelEmailItem: ProfileViewModelItem {
    
    var type: ProfileViewModelItemType {
        return .email
    }
    var sectionTitle: String {
        return "Email"
    }
    var isCollapsed = true

    var email: String
    
    init(email: String) {
        self.email = email
    }
}

extension ProfileViewModel: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let item = items[section]
        
        return item.isCollapsible && item.isCollapsed ? 0 : item.rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = items[indexPath.section]

        switch item.type {
        case .nameAndPicture:
            if let cell = tableView.dequeueReusableCell(withIdentifier: NamePictureCell.identifier, for: indexPath) as? NamePictureCell {
                cell.item = item
                return cell
            }
        case .about:
            if let cell = tableView.dequeueReusableCell(withIdentifier: AboutCell.identifier, for: indexPath) as? AboutCell {
                cell.item = item
                return cell
            }
        case .email:
            if let cell = tableView.dequeueReusableCell(withIdentifier: EmailCell.identifier, for: indexPath) as? EmailCell {
                cell.item = item
                return cell
            }
        case .friend:
            if let item = item as? ProfileViewModeFriendsItem, let cell = tableView.dequeueReusableCell(withIdentifier: FriendCell.identifier, for: indexPath) as? FriendCell {
                let friend = item.friends[indexPath.row]
                cell.item = friend
                return cell
            }
        case .attribute:
            if let item = item as? ProfileViewModeAttributeItem, let cell = tableView.dequeueReusableCell(withIdentifier: AttributeCell.identifier, for: indexPath) as? AttributeCell {
                cell.item = item.attributes[indexPath.row]
                return cell
            }
        }
        return UITableViewCell()
    }    
}

extension ProfileViewModel: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.identifier) as? HeaderView {

            let item = items[section]
            
            headerView.item = item
            headerView.section = section
            headerView.delegate = self
            
            return headerView
        }
        return UIView()
    }
}

extension ProfileViewModel: HeaderViewDelegate {
    
    func toggleSection(header: HeaderView, section: Int) {
        
        var item = items[section]
        
        if item.isCollapsible {
            // Toggle collapse
            let collapsed = !item.isCollapsed
            item.isCollapsed = collapsed
            header.setCollapsed(collapsed: collapsed)
            // Adjust the number of the rows inside the section
            reloadSections?(section)
        }
    }
}
