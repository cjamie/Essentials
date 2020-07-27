//
//  RemoteFeedLoader.swift
//  MyEssentialFeed
//
//  Created by Jamie Chu on 7/26/20.
//  Copyright © 2020 Jamie Chu. All rights reserved.
//

import Foundation

//responsible for going out to the internet, and loading (via http) given a url
public protocol HTTPClient {
    func get(from: URL, completion: @escaping (Error) -> Void)
}

// responsible for loading
public class RemoteFeedLoader {

    private let client: HTTPClient
    private let url: URL
    
    public enum Error: Swift.Error {
        case connectivity
    }
    
    // MARK: - Init
    
    public init(url: URL, client: HTTPClient) {
        self.client = client
        self.url = url
    }
    
    public func load(completion: ((Error)->Void)? = nil) {
        client.get(from: url) { error in
            completion?(.connectivity) // for now, this is hardcoded to return connectivity
        }
    }

}
