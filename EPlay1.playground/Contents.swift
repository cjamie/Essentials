import UIKit

class ApiClient {
    // type system enforces that this property cannot be changes/mutated
    
    static let instance = ApiClient() // make this a var to make it setable but this introduces global state
    func login(completion: (LoggedInUser) -> ()) {}
}

ApiClient.instance


struct LoggedInUser {
    
}

class MockApiClient: ApiClient {
    
}

class LoginController: UIViewController {
    
    var api = ApiClient.instance   
    
    
    func didTapLoginButton() {
        api.login { user in
            // show next screen
        }
    }
}
