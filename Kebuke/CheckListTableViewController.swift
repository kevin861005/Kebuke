//
//  CheckListTableViewController.swift
//  Kebuke
//
//  Created by NAI LUN CHEN on 2023/4/30.
//

import UIKit

class CheckListTableViewController: UITableViewController {
    
    var orders: [OrderDetail] = []

    override func viewDidLoad() {
        super.viewDidLoad()

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
        return orders.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(OrderDetailTableViewCell.self)", for: indexPath) as! OrderDetailTableViewCell
        
        let orderDetail = orders[indexPath.row]
        
        let drinkDetail = orderDetail.drinkDetail
        
        cell.buyerNameLabel.text = "訂購人：" + orderDetail.buyerName
        
        cell.drinkInfoLabel.text = drinkDetail.drinkName + "/" + orderDetail.sugarLevel + "/" + orderDetail.iceLevel
        
        cell.priceLabel.text = "\(orderDetail.drinkPrice)元"

        // Configure the cell...

        return cell
    }
    
    
    @IBSegueAction func showOrder(_ coder: NSCoder) -> OrderViewController? {
        guard let row = tableView.indexPathForSelectedRow?.row else { return nil }
        
        let order = orders[row]
        
        let orderViewController = OrderViewController(coder: coder)
        
        orderViewController?.orderDetail = OrderDetail(buyerName: order.buyerName, drinkSize: order.drinkSize, drinkPrice: order.drinkPrice, sugarLevel: order.sugarLevel, iceLevel: order.iceLevel, drinkDetail: order.drinkDetail)
        
        return orderViewController
    }
    
    @IBAction func unwindToCheck(_ unwindSegue: UIStoryboardSegue) {
        if let source = unwindSegue.source as? OrderViewController,
           let orderDetail = source.orderDetail {
            if let indexPath = tableView.indexPathForSelectedRow {
                orders[indexPath.row] = orderDetail
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    @IBAction func purchase(_ sender: Any) {
        if orders.count == 0 {
            let alertController = UIAlertController(title: "操作錯誤", message: "請至少購買一杯飲料", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "確定", style: .default))
            
            present(alertController, animated: true)
        } else {
            var totalPrice: Int = 0
            for order in orders {
                totalPrice += order.drinkPrice
            }
            
            let alertController = UIAlertController(title: "購買成功", message: "總共購買\(orders.count)杯，總計\(totalPrice)元", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "確定", style: .default, handler: { (action) in
                self.orders.removeAll()
                self.tableView.reloadData()
            }))
            
            present(alertController, animated: true)
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            orders.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
