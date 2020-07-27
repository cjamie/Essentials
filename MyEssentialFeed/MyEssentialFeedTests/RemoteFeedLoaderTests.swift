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
        XCTAssertEqual(client.requestedURLs, [urlInput])
    }
    
    func test_loadTwice_requestsDataFromURLTwice() {
        
        let inputUrl = anyURL()
        
        let (client, sut) = makeSUT(url: inputUrl)
        sut.load()
        sut.load()
        
        XCTAssertEqual(client.requestedURLs, [inputUrl, inputUrl])
    }

    
    func test_load_deliversErrorOnClientError() {
        let (client, sut) = makeSUT()
    
        var capturedErrors: [RemoteFeedLoader.Error] = []
        
        sut.load { capturedErrors.append($0) }
                 
        client.complete(with: anyError())
        
        XCTAssertEqual(capturedErrors, [.connectivity])
        
    }
    
    
    
    // MARK: - Helpers
    
    private func anyError() -> Error {
        return NSError(domain: "test", code: 0)
    }
    
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
        
        var requestedURLs: [URL] {
            return messages.map { $0.url }
        }
        
        private var messages: [(url: URL, completion: (Error) -> Void)] = []
        
        func get(from url: URL, completion: @escaping (Error) -> Void) {
            messages.append((url, completion))
        }
        
        func complete(with error: Error, at index: Int = 0) {
            messages[index].completion(error)
        }
    }

}
