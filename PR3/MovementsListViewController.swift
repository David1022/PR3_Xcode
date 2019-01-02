//
//  MovementsListViewController.swift
//  PR3
//
//  Copyright © 2018 UOC. All rights reserved.
//

import UIKit

class MovementsListViewController: UITableViewController {
    var movements: [Movement]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupMovements()
    }
    
    func setupMovements() {
        tableView.estimatedRowHeight = 40
        tableView.rowHeight = UITableView.automaticDimension
        movements = Services.getMovements()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movements.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movementsCount = movements.count
        
        if indexPath.row < movementsCount {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovementCell", for: indexPath) as! MovementCell
            
            let movement = movements[indexPath.row]
            
            let description = movement.movementDescription
            
            let amountFormatter = NumberFormatter()
            amountFormatter.numberStyle = .currency
            amountFormatter.currencySymbol = "€"
            amountFormatter.currencyDecimalSeparator = ","
            amountFormatter.currencyGroupingSeparator = "."
            amountFormatter.positiveFormat = "#,##0.00 ¤"
            amountFormatter.negativeFormat = "-#,##0.00 ¤"
            
            let amount = amountFormatter.string(from: movement.amount as NSDecimalNumber) ?? "Not available"
            
            var amountColor: UIColor
            if movement.amount >= 0 {
                amountColor = UIColor.black
            } else {
                amountColor = UIColor.red
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.string(from: movement.date)
            
            var backgroundColor: UIColor
            if movement.rejected {
                backgroundColor = UIColor.orange.lighter()
            } else {
                backgroundColor = UIColor.white
            }            
            
            cell.configureWith(Description: description, Date: date, Amount: amount, AmountColor: amountColor, BackgroundColor: backgroundColor)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LastMovementCell", for: indexPath)
            
            return cell
        }
    }
    
    @IBAction func filterChanged(_ sender: UISegmentedControl) {
        let allMovements = Services.getMovements()
        
        switch sender.selectedSegmentIndex {
        case 0:
            movements = allMovements
        case 1:
            let filteredMovements = allMovements.filter {
                $0.category == "Transfers"
            }
            movements = filteredMovements
        case 2:
            let filteredMovements = allMovements.filter {
                $0.category == "Credit cards"
            }
            movements = filteredMovements
        case 3:
            let filteredMovements = allMovements.filter {
                $0.category == "Direct debits"
            }
            movements = filteredMovements
        default:
            fatalError()
        }
        
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueToMovementDetail" {
            if let row = tableView.indexPathForSelectedRow?.row {
                let movement = movements[row]
                
                let destinationViewController = segue.destination as! MovementDetailViewController
                
                destinationViewController.movement = movement
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
}
