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
    
//    func get(from: URL, completion: @escaping (Error?, HTTPURLResponse?) -> Void)
    
    func get(from: URL, completion: @escaping (Result<HTTPURLResponse, Error>) -> Void)

}

// responsible for loading
public class RemoteFeedLoader {

    private let client: HTTPClient
    private let url: URL
    
    public enum Error: Swift.Error, Equatable {
        case connectivity
        case invalidStatus(code: Int)
    }
    
    // MARK: - Init
    
    public init(url: URL, client: HTTPClient) {
        self.client = client
        self.url = url
    }
    
    public func load(completion: @escaping ((Error)->Void)) {
        client.get(from: url) {
            
            switch $0 {
            case .failure(let error):
                completion(.connectivity)
            case .success(let response):
                completion(.invalidStatus(code: response.statusCode))
            }
        }
    }

}
