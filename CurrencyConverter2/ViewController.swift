//
//  ViewController.swift
//  CurrencyConverter2
//
//  Created by Ali serkan Boyracı  on 7.10.2022.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var chfLabel: UILabel!
    @IBOutlet var cadLabel: UILabel!
    @IBOutlet var gbpLabel: UILabel!
    @IBOutlet var usdLabel: UILabel!
    @IBOutlet var tryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getRatesClicked(_ sender: Any) {
        // 1. Request & session
        // 2. Response & Data
        // 3. Parsing & JSON Serialization
        
        
        // 1.
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/CurrencyData/main/currency.json")
        
        let session = URLSession.shared
        
        //closure
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error  != nil {
                
                let alert = UIAlertController(title: "Error!!!", message: error?.localizedDescription, preferredStyle: .alert)
                
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
                
            } else {
                //2.
                if data != nil {
                    do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                        as! Dictionary<String, Any> // we need dict, to use data. key-string, value-any
                        
                        
                        //ASYNC - main thread- background works. to use it same time.
                        
                        DispatchQueue.main.async {
                        
                            //print(jsonResponse["rates"]) also another dict, we need to take only particular rates from this dict.
                            if let rates = jsonResponse["rates"] as? [String:Any] {
                                //print(rates) we take all data string and double
                                
                                if let chf = rates["CHF"] as? Double {
                                    self.chfLabel.text = "CHF: \(chf)" // we have to use self. because of main.async
                                }
                                if let cad = rates["CAD"] as? Double {
                                    self.cadLabel.text = "CAD: \(cad)" // we have to use self. because of main.async
                                }
                                if let gbp = rates["GBP"] as? Double {
                                    self.gbpLabel.text = "GBP: \(gbp)" // we have to use self. because of main.async
                                }
                                if let usd = rates["USD"] as? Double {
                                    self.usdLabel.text = "USD: \(usd)" // we have to use self. because of main.async
                                }
                                if let trl = rates["TRY"] as? Double {
                                    self.tryLabel.text = "TRY: \(trl)" // we have to use self. because of main.async
                                }                                
                            }
                            
                        }
                        
                        
                    } catch {
                        print("error")
                    }
                    
                    
                    
                    
                    
                }
            }
        }
        
        task.resume()
       
        
        
        
        
        
        
    }
    
}

