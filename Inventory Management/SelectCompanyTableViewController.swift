//
//  SelectCompanyTableViewController.swift
//  Inventory Management
//
//  Created by Nishant Patel on 3/27/17.
//  Copyright © 2017 Nishant Patel. All rights reserved.
//

import UIKit

class SelectCompanyTableViewController: UITableViewController, AddNewCompanyDelegate {
    
    @IBOutlet weak var companyNameLabel: UILabel!
    var companies = [NSDictionary]()
    var CM = CompanyModel()
    weak var delegate: AddOrderDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllCompanyFromServer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func fetchAllCompanyFromServer() {
        CM.getAllCompanies { (companies) in
            self.companies = companies
            self.tableView.reloadData()
        }
    }
    
    @IBAction func addNewCompanyButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "addCompanySegue", sender: sender)
    }
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.cancelButtonPressed(controller: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectProductsForCompanySegue" {
            let controller = segue.destination as! SelectProductsViewController
            let company = sender as! NSDictionary
            controller.company = company
            controller.title = "Select Product(s) for \(company["name"]!)"
            controller.productsForSelectCompany = company["products"] as! [NSDictionary]
        }
        
        if segue.identifier == "addCompanySegue" {
            let navController = segue.destination as! UINavigationController
            let controller = navController.topViewController as! AddNewCompanyViewController
            controller.delegate = self
            controller.title = "Add New Company"
        }
    }
    
    func saveButtonPressed(controller: AddNewCompanyViewController, newCompany: NSDictionary) {
        self.companies = [NSDictionary]()
        fetchAllCompanyFromServer()
        dismiss(animated: true, completion: nil)
    }
    
    func cancelButtonPressed(controller: AddNewCompanyViewController) {
        dismiss(animated: true, completion: nil)
    }

}

extension SelectCompanyTableViewController {
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count + 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "addNewCompanyButton", for: indexPath)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "selectCompanyCell", for: indexPath) as! SelectCompanyTableViewCell
        let company = companies[indexPath.row - 1]
        
        cell.companyNameLabel.text = company["name"] as? String
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "selectProductsForCompanySegue", sender: companies[indexPath.row - 1])
    }
    
    
}
