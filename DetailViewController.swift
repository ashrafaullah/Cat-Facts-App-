//Ashraf Ullah
//IT 315
//Final

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var lblElevation: UILabel!
    
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var lblLength: UILabel!
    
    @IBOutlet weak var imgHT: UIImageView!
    
    @IBOutlet weak var detailDescriptionLabel: UILabel!


    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.Fact
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
        imgHT.image = detailItem?.CatImage
        
        //lblElevation.text = detailItem?.TrailElevation
        //lblLength.text = detailItem?.TrailLength
        //lblTime.text = detailItem?.TrailTime
        
        
        
        
    }

    var detailItem: CatFact? {
        didSet {
            // Update the view.
            configureView()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Find the right Segue
        if segue.identifier == "showSubDetail" {
            let controller = segue.destination as! SubDetailViewController
            // pass on the selected object from the Array to the detail controller's object.
            controller.selectedTrail = detailItem!
        }
    }
}

