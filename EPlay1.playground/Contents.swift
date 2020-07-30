
import UIKit

    
class MyClass {
    
    deinit {
        print("\(self) died")
    }
}

do {
    let myClass = MyClass()
    CFGetRetainCount(myClass)
}
