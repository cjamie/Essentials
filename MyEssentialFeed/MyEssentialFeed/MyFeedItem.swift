//
//  MyFeedItem.swift
//  MyEssentialFeed
//
//  Created by Jamie Chu on 7/26/20.
//  Copyright © 2020 Jamie Chu. All rights reserved.
//

import Foundation

public struct FeedItem {
    let id: UUID
    let description: String?
    let location: String?
    let url: URL
}
