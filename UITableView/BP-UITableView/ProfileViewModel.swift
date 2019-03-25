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
}

extension ProfileViewModelItem {
    
    var rowCount: Int {
        return 1
    }
}

protocol ProfileViewModelDelegate: class {
    func didFinishUpdates()
}

class ProfileViewModel: NSObject {
    
    var items = [ProfileViewModelItem]()
    
    weak var delegate: ProfileViewModelDelegate?
    
    func loadData() {
        guard let data = dataFromFile("ServerData"), let profile = Profile(data: data) else {
            return
        }
        loadServerData(profile)
    }
    
    func loadUpdateData() {
        guard let data = dataFromFile("ServerData_New"), let profile = Profile(data: data) else {
            return
        }
        loadServerData(profile)
    }
    
    private func loadServerData(_ profile: Profile) {
        
        items.removeAll()
        
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
        
        delegate?.didFinishUpdates()
    }
}

class ProfileViewModelNamePictureItem: ProfileViewModelItem {
    
    var type: ProfileViewModelItemType {
        return .nameAndPicture
    }
    
    var sectionTitle: String {
        return "Main Info"
    }
    
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
        return items[section].rowCount
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return items[section].sectionTitle
    }
}
