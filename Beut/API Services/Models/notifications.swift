//
//  Notifications_Model.swift
//  Esfenja
//
//  Created by ProjectEgy on 27/07/2022.
//

import Foundation
// MARK: - Notification

struct UserNotification: Codable {
    let notificationID: Int?
    let title, notificationDescription, time: String?
    let isSeen: Bool?
    let type, requestID: Int?

    enum CodingKeys: String, CodingKey {
        case notificationID = "NotificationId"
        case title = "Title"
        case notificationDescription = "Description"
        case time = "Time"
        case isSeen = "IsSeen"
        case type = "Type"
        case requestID = "RequestId"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        notificationID = try values.decodeIfPresent(Int.self, forKey: .notificationID)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        notificationDescription = try values.decodeIfPresent(String.self, forKey: .notificationDescription)
        time = try values.decodeIfPresent( String.self, forKey: .time)
        isSeen = try values.decodeIfPresent(Bool.self, forKey: .isSeen)
        type = try values.decodeIfPresent(Int.self, forKey: .type)
        requestID = try values.decodeIfPresent(Int.self, forKey: .requestID)
    }
}
