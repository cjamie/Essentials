import UIKit


protocol FeedLoader {
    func loadFeed(completion: @escaping (([String]) -> Void))
}

class FeedController: UIViewController {

    var loader: FeedLoader!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loader.loadFeed { loadedItems in
            
        }
    }
    
    convenience init(loader: FeedLoader) {
        self.init()
        self.loader = loader
    }
    
}



final class RemoteFeedLoader: FeedLoader {
    func loadFeed(completion: @escaping (([String]) -> Void)) {
        // do something
        print("-=- remote feed loader")
        
        completion([])
    }
}

final class LocalFeedLoader: FeedLoader {
    func loadFeed(completion: @escaping (([String]) -> Void)) {
        // do something
    }
}

let feedVC = FeedController(loader: RemoteFeedLoader())
_ = feedVC.view
