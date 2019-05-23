//Ashraf Ullah
//IT 315
//Final

import UIKit

class MasterViewController: UITableViewController {
    var CFArray = [CatFact]()

    override func viewDidLoad() {
        super.viewDidLoad()
        initilizeRestData()
    }
    func initilizeRestData() {
        // 1) Build the URL for the End Point
        let endPoint =  "https://api.myjson.com/bins/pbgpu"
        let jsURL:URL = URL(string: endPoint)!
        // 2) execute the End Point Resulting in bringing down the JSON
        let jsonUrlData = try? Data (contentsOf: jsURL)
        print(jsonUrlData ?? "ERROR: No Data To Print. JSONURLData is Nil")
        if(jsonUrlData != nil){
            //3) Consume the JSON
            // 4) take the JSON data and serialize it into a Dictionary
            let dictionary:NSDictionary =
                (try! JSONSerialization.jsonObject(with: jsonUrlData!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
            
            print(dictionary)
            let CFD = dictionary["CatFacts"]! as! [[String:AnyObject]]
            for index in 0...CFD.count - 1 {
                let singleFact = CFD[index]
                let cf  = CatFact()
                //cf.TrailDifficulty = singleFact["TrailDifficulty"] as! String
                cf.Fact = singleFact["fact"] as! String
                //cf.TrailElevation = singleFact["TrailElevation"] as! String
                //cf.TrailID = singleFact["TrailID"] as! Int
                let imgName2 = singleFact["image"] as! String
                cf.CatImage = extractImage(named: imgName2)
                //cf.TrailLength = singleFact["TrailLength"] as! String
                //cf.TrailTime = singleFact["TrailTime"] as! String
                cf.FactWebsite = singleFact["website"] as! String
                CFArray.append(cf)
                
            } //for loop close
        } // if condition close
    } // function close
    
    func extractImage(named:String) -> UIImage {
        // get the image form the URL
        let urlString = "https://cdn2.thecatapi.com/images/" + named
        let uri = URL(string: urlString)
        let dataBytes = try? Data(contentsOf: uri!)
        let img = UIImage(data: dataBytes!)
        return img!
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    
    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Find the right Segue
        if segue.identifier == "showDetail" {
           //find the selected Row Number from the TableView
            if let indexPath = tableView.indexPathForSelectedRow {
               //get the corresponding Object fromt he Object Array
                // for example if the second row is touched. The Second object from the array is selected.
                 let selectedHT = CFArray[indexPath.row]
                //find the destination Controller that the segue is connected to
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                // pass on the selected object from the Array to the detal controller's object.
                controller.detailItem = selectedHT
                
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CFArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let selectedHT = CFArray[indexPath.row]

        // style the table view
        tableView.separatorColor = UIColor.blue
        tableView.tableFooterView =
            UIView(frame: CGRect(x:0.0, y:0.0, width:0.0, height:0.0))
        // set style on the image view
        cell.imageView?.contentMode = .scaleAspectFit
        cell.imageView!.layer.cornerRadius = 20
        cell.imageView!.clipsToBounds = true
        
        cell.textLabel!.text = selectedHT.Fact
        //cell.detailTextLabel!.text = selectedHT.TrailDifficulty
        cell.imageView?.image = selectedHT.CatImage
        
        
        
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

}

