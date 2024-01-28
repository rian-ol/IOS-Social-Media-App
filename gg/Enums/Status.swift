//
//  Status.swift
//  gg
//
//  Created by Rian O'Leary on 23/08/2023.
//

import Foundation


enum FriendStatus{
    case normal
    case request
    case friend
}

enum LinkStatus{
    case normal
    case request
    case friend
}
enum RelationshipStatus{
    case normal
    case request
    case friend
}



enum chatTypes: String, Identifiable, CaseIterable {
    case friend
    case relationship
    case link
    
    var id: String { self.rawValue.capitalized}
}
