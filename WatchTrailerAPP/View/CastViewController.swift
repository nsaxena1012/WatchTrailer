//
//  CastViewController.swift
//  WatchTrailerAPP
//
//  Created by apple on 12/12/24.
//

import UIKit

class CastViewController: UIViewController {
    @IBOutlet var castTableView: UITableView!
    @IBOutlet var movieTitle: UILabel!
    var movieCastTitle : String? 
      
    var castNames: [String] = []
    var directorNames: [String] = []
    var genres: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTitle.text = movieCastTitle
        castTableView.dataSource = self
        castTableView.delegate = self
        castTableView.register(UINib(nibName: "CastTableViewCell", bundle: nil), forCellReuseIdentifier: "CastTableViewCell")
        castTableView.contentInsetAdjustmentBehavior = .automatic
        castTableView.clipsToBounds = true
    }
    

}
extension CastViewController : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
           // We have three sections: Cast, Director, Genres
           return 2
       }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
                case 0: 
                    return castNames.count
                case 1:
                     return genres.count
                default:
                    return 0
                }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
      //  headerView.backgroundColor = UIColor.systemGray6  // Optional: Set background color for the header

        let headerLabel = UILabel()
        headerLabel.font = UIFont.boldSystemFont(ofSize: 18) // Customize font size and weight
        headerLabel.textColor = UIColor.white                 // Change text color to red
        headerLabel.translatesAutoresizingMaskIntoConstraints = false

        // Set the text based on the section
        switch section {
        case 0:
            headerLabel.text = "Cast"
            headerLabel.textAlignment = .center
            
        case 1:
            headerLabel.text = "Genres"
            headerLabel.textAlignment = .center
        default:
            headerLabel.text = ""
        }

        // Add the label to the header view
        headerView.addSubview(headerLabel)
        
        // Add constraints for proper alignment
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            headerLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 8),
            headerLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -8)
        ])

        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50  // Ensure a fixed height for the header view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CastTableViewCell", for: indexPath) as! CastTableViewCell
        switch indexPath.section {
        
               case 0: // Cast
                   cell.textLabel?.text = castNames[indexPath.row]
                  cell.textLabel?.textColor = .white
            cell.textLabel?.textAlignment = .center
               case 1: // Director
                   cell.textLabel?.text = genres[indexPath.row]
                   cell.textLabel?.textColor = .white
            cell.textLabel?.textAlignment = .center
               default:
                   break
               }
               
               return cell
           }
    }
    
    

