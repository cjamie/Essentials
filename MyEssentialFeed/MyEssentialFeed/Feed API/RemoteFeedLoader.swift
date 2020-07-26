//
//  RemoteFeedLoader.swift
//  MyEssentialFeed
//
//  Created by Jamie Chu on 7/26/20.
//  Copyright © 2020 Jamie Chu. All rights reserved.
//

import Foundation

public protocol HTTPClient {
    func get(from: URL)
}

public class RemoteFeedLoader {

    private let client: HTTPClient
    private let url: URL
    
    // MARK: - Init
    
    public init(url: URL, client: HTTPClient) {
        self.client = client
        self.url = url
    }
    
    public func load() {
        client.get(from: url)
    }

}
