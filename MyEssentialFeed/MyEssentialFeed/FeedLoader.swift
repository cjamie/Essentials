//
//  FeedLoader.swift
//  MyEssentialFeed
//
//  Created by Jamie Chu on 7/26/20.
//  Copyright © 2020 Jamie Chu. All rights reserved.
//

import Foundation

enum LoadFeedResult {
    case success([FeedItem])
    case error(Error)
}

protocol FeedLoader {
    func load(completion: @escaping () -> Void)
}
