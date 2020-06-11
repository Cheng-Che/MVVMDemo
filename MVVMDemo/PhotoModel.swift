//
//  PhotoModel.swift
//  MVVMDemo
//
//  Created by Steven Hsieh on 2020/6/5.
//  Copyright © 2020 Steven Hsieh. All rights reserved.
//

import Foundation

struct PhotoModel: Codable {
    var id: String
    var created_at: String
    var description: String?
    var alt_description: String
    var urls: Urls
    var likes: Int
    var user: User
}

struct Urls: Codable {
    var regular: String
}

struct User: Codable {
    var id: String
    var username: String
    var bio: String?
    var profile_image: ProfileImg
    var total_collections: Int
    var total_likes: Int
    var total_photos: Int
}

struct ProfileImg: Codable {
    var medium: String
}

