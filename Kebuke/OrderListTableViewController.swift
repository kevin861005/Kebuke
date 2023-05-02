//
//  OrderListTableViewController.swift
//  Kebuke
//
//  Created by NAI LUN CHEN on 2023/4/29.
//

import UIKit

class OrderListTableViewController: UITableViewController {
    
    var records = [DrinksResponse.Record]()
    
    var orders = [OrderDetail]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchDrinksList()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return records.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(OrderListTableViewCell.self)", for: indexPath) as! OrderListTableViewCell
        
        let record = records[indexPath.row]
        
        let field = record.fields
        
        // 飲料名稱
        cell.drinkNameLabel.text = field.name
        
        // 飲料概述
        //cell.drinkDescriptionLabel.text = field.description
        
        let drinksImage = field.image[0]
        
        // 先給預設圖片
        cell.drinkImageView.image = UIImage(named: "可不可LOGO")
        
        // 再抓API給的圖片
        URLSession.shared.dataTask(with: drinksImage.url) { data, response, error in
            if let data,
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    cell.drinkImageView.image = image
                }
            }
        }.resume()
        
        cell.mediumPriceLabel.text = "中杯：\(field.mediumPrice)"
        
        if let largePrice = field.largePrice {
            cell.largePriceLabel.text = "大杯：\(largePrice)"
        } else {
            cell.largePriceLabel.isHidden = true
        }

        // Configure the cell...

        return cell
    }
    
    func fetchDrinksList() {
        let apiToken = "patoJzOZwc1MkcuRG.ed0b8cae4ad5149ad1bc3ee9517daedf73e2735fd5f10edf1f1cdc652c7ad71c"
        
        let drinksListUrlString = "https://api.airtable.com/v0/appZAZGgidgkfQypV/Drinks"
        let drinksListUrl = URL(string: drinksListUrlString)!
        
        var request = URLRequest(url: drinksListUrl)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response , error in
            if let data {
                let decoder = JSONDecoder()
                do {
                    let drinksResponse = try decoder.decode(DrinksResponse.self,
                                                            from: data)
                    
                    self.records = drinksResponse.records
                    
                    DispatchQueue.main.sync {
                        self.tableView.reloadData()
                    }
                } catch {
                    print(error)
                    // show error alert
                }
            } else {
                // show error alert
            }
        }.resume()
    }

    @IBSegueAction func showOrder(_ coder: NSCoder) -> OrderViewController? {
        guard let row = tableView.indexPathForSelectedRow?.row else { return nil }
        
        let record = records[row]
        
        let field = record.fields
        
        let drinksImage = field.image[0]
        
        let thumbnails = drinksImage.thumbnails
        
        let orderViewController = OrderViewController(coder: coder)
        
        orderViewController?.drinkDetail = DrinkDetail(drinkImage: thumbnails.large.url, drinkIntroduction: field.introduction, drinkDescription: field.description, mediumPrice: field.mediumPrice, largePrice: field.largePrice, drinkName: field.name)
        
        return orderViewController
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if "showCheckList" == identifier, orders.isEmpty {
            let alertController = UIAlertController(title: "操作錯誤", message: "請先選擇飲料", preferredStyle: .alert)

            alertController.addAction(UIAlertAction(title: "確定", style: .default))

            present(alertController, animated: true)
            
            return false
        } else {
            return true
        }
    }
    
    @IBAction func unwindToList(_ unwindSegue: UIStoryboardSegue) {
        if let source = unwindSegue.source as? OrderViewController,
           let orderDetail = source.orderDetail {
            orders.insert(orderDetail, at: 0)
            //let newIndexPath = IndexPath(row: 0, section: 0)
            //tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
    @IBSegueAction func showCheckList(_ coder: NSCoder) -> CheckListTableViewController? {
        let checkListTableViewController = CheckListTableViewController(coder: coder)

        checkListTableViewController?.orders = orders

        return checkListTableViewController
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if "showCheckList" == segue.identifier {
//            let checkListTableViewController = segue.destination as! CheckListTableViewController
//
//            print(orders)
//
//            checkListTableViewController.orders = orders
//        }
//    }
}
