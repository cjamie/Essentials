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
        XCTAssert(client.requestedURLs.isEmpty)
    }
    
    func test_load_requestsDataFromURL() {
        // GIVEN
        let urlInput = anyURL()
        let (client, sut) = makeSUT(url: urlInput)
        
        // WHEN
        sut.load()
        
        // THEN
        XCTAssertEqual(client.requestedURLs.last, urlInput)
    }
    
    func test_loadTwice_requestsDataFromURLTwice() {
        let inputUrl = anyURL()
        let (client, sut) = makeSUT(url: inputUrl)
        
        sut.load()
        sut.load()
        
        XCTAssertEqual(client.requestedURLs, [inputUrl, inputUrl])
    }

    
    // MARK: - Helpers
    
    private func anyURL() -> URL {
        return URL(string: Constants.arbitraryUrlString)!
    }
    
    private enum Constants {
        static let arbitraryUrlString = "https://a-url.com"
    }
    
    private func makeSUT(
        client: HTTPClientSpy = HTTPClientSpy(),
        url: URL = URL(string: Constants.arbitraryUrlString)!
    ) -> (client: HTTPClientSpy, loader: RemoteFeedLoader) {
        return (client, RemoteFeedLoader(url: url, client: client))
    }

    private class HTTPClientSpy: HTTPClient {
        var requestedURLs: [URL] = []
        
        func get(from url: URL) {
            requestedURLs.append(url)
        }
    }

}
