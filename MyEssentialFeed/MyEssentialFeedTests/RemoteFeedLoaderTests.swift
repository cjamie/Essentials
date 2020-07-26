//
//  RemoteFeedLoaderTests.swift
//  MyEssentialFeedTests
//
//  Created by Jamie Chu on 7/26/20.
//  Copyright © 2020 Jamie Chu. All rights reserved.
//

import XCTest
import MyEssentialFeed

class RemoteFeedLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        // GIVEN
        
        // WHEN
        let (client, _) = makeSUT()

        // THEN
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL() {
        // GIVEN
        let url = URL(string: "https://a-url.com")!
        let (client, sut) = makeSUT(url: url)
        
        // WHEN
        sut.load()
        
        // THEN
        XCTAssertEqual(client.requestedURL, url)
    }
    
    func makeSUT(client: HTTPClientSpy = HTTPClientSpy(), url: URL = URL(string: "https://a-url.com")!) -> (client: HTTPClientSpy, loader: RemoteFeedLoader) {
        return (
            client,
            RemoteFeedLoader(url: url, client: client)
        )
    }
    
    // MARK: - Helpers
    
    class HTTPClientSpy: HTTPClient {
        var requestedURL: URL?
        
        func get(from url: URL) {
            requestedURL = url
        }
    }

}
