//
//  FakeLoanTableViewController.swift
//  Fake Loans
//
//  Created by Sorfian on 25/03/23.
//

import UIKit

class FakeLoanTableViewController: UITableViewController {
    
    enum Section {
        case all
    }
    
    private let fakeLoanURL = "https://api.kivaws.org/v1/loans/newest.json"
    private var loans: [Loan] = []
    
    lazy var dataSource = configureDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tableView.estimatedRowHeight = 92.0
        tableView.rowHeight = UITableView.automaticDimension
        
        getLatestLoans()
    }
    
    func getLatestLoans() {
        guard let loanUrl = URL(string: fakeLoanURL) else {
            return
        }
        
        let request = URLRequest(url: loanUrl)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            if let error = error {
                print(error)
                return
            }
            
            // Parse JSON data
            if let data = data {
                self.loans = self.parseJsonData(data: data)
                
                // Update table view's data
                OperationQueue.main.addOperation({
                    self.updateSnapshot()
                })
            }
        })
        
        task.resume()
    }

    func parseJsonData(data: Data) -> [Loan] {
        
        var loans = [Loan]()
        
        let decoder = JSONDecoder()
        
        do {
            let loanDataStore = try decoder.decode(LoanDataStore.self, from: data)
            loans = loanDataStore.loans
            
        } catch {
            print(error)
        }
        
        return loans
    }
    
    func configureDataSource() -> UITableViewDiffableDataSource<Section, Loan> {

        let cellIdentifier = "loancell"

        let dataSource = UITableViewDiffableDataSource<Section, Loan>(
            tableView: tableView,
            cellProvider: {  tableView, indexPath, loan in
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FakeLoanTableViewCell

                cell.nameLabel.text = loan.name
                cell.countryLabel.text = loan.country
                cell.useLabel.text = loan.use
                cell.amountLabel.text = "$\(loan.amount)"

                return cell
            }
        )

        return dataSource
    }

    func updateSnapshot(animatingChange: Bool = false) {

        // Create a snapshot and populate the data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Loan>()
        snapshot.appendSections([.all])
        snapshot.appendItems(loans, toSection: .all)

        dataSource.apply(snapshot, animatingDifferences: animatingChange)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }


}
