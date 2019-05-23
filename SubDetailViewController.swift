//Ashraf Ullah
//IT 315
//Final

import Foundation
import UIKit
import WebKit
import AVKit

class SubDetailViewController : UIViewController {
   
    
    @IBOutlet weak var wbBrowser: WKWebView!
 
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let myURL = URL(string:"http://www.sciencekids.co.nz/sciencefacts/animals/cat.html")
        
        //let myURL = URL(string: ("http://" + (selectedTrail.FactWebsite)))
        
        let myRequest = URLRequest(url: myURL!)
        
        wbBrowser.load(myRequest)
        
    }
    
    
    
    var selectedTrail:CatFact = CatFact()
    
}

