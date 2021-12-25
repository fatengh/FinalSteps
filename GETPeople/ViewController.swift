//
//  ViewController.swift
//  GETPeople
//
//  Created by admin on 22/12/2021.
//

import UIKit


class ViewController: UITableViewController {
    
var pepole = [String]()
    
    override func viewDidLoad() {
            super.viewDidLoad()
            StarWarsModel.getAllPeople(completionHandler: { // passing what becomes "completionHandler" in the 'getAllPeople' function definition in StarWarsModel.swift
                data, response, error in
                    do {
                        // Try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
                        if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                            if let results = jsonResult["results"] as? NSArray {
                                for person in results {
                                    let personDict = person as! NSDictionary
                                    self.pepole.append(personDict["name"]! as! String)
                                }
                            }
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    } catch {
                        print("Something went wrong")
                    }
            })
        }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pepole.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = pepole[indexPath.row]
        return cell
    }
}

