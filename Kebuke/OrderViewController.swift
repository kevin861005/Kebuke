//
//  OrderViewController.swift
//  Kebuke
//
//  Created by NAI LUN CHEN on 2023/4/29.
//

import UIKit

class OrderViewController: UIViewController {
    
    var orderDetail: OrderDetail?
    
    var drinkDetail: DrinkDetail!
    
    let sugarLevels = ["全糖", "少糖", "半糖", "微糖", "二分糖", "一分糖", "無糖"]
    
    let iceLevels = ["正常冰", "少冰", "微冰", "去冰", "完全去冰", "常溫", "溫", "熱"]
    
    @IBOutlet var iceLevelButtons: [UIButton]!
    
    @IBOutlet var sugarLevelButtons: [UIButton]!
    
    @IBOutlet weak var sizeSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var sugarLevelSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var iceLevelSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var drinkDescriptionLabel: UILabel!
    
    @IBOutlet weak var drinkImageView: UIImageView!
    
    @IBOutlet weak var doneBarButtonItem: UIBarButtonItem!
    
    @IBOutlet weak var orderButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drinkImageView.image = UIImage(named: "可不可LOGO")
        
        setSugarSementedControl()
        
        setIceSementedControl()
        
        if let order = orderDetail {
            let drinkDetail = order.drinkDetail
            
            drinkDescriptionLabel.text = drinkDetail.drinkName + "：" + drinkDetail.drinkDescription
            
            nameTextField.text = order.buyerName
            
            nameTextField.isEnabled = false
            
            orderButton.isHidden = true
            
            sizeSegmentedControl.setTitle("中杯\(drinkDetail.mediumPrice)元", forSegmentAt: 0)
            
            if let largePrice = drinkDetail.largePrice {
                sizeSegmentedControl.setTitle("大杯\(largePrice)元", forSegmentAt: 1)
            } else {
                sizeSegmentedControl.setTitle("無提供大杯", forSegmentAt: 1)
                sizeSegmentedControl.setEnabled(false, forSegmentAt: 1)
            }
            
            let drinkSize = order.drinkSize
            if "中杯" == drinkSize {
                sizeSegmentedControl.selectedSegmentIndex = 0
            } else {
                sizeSegmentedControl.selectedSegmentIndex = 1
            }
            
            let sugarLevel = order.sugarLevel
            switch sugarLevel {
            case "全糖":
                sugarLevelSegmentedControl.selectedSegmentIndex = 0
            case "少糖":
                sugarLevelSegmentedControl.selectedSegmentIndex = 1
            case "半糖":
                sugarLevelSegmentedControl.selectedSegmentIndex = 2
            case "微糖":
                sugarLevelSegmentedControl.selectedSegmentIndex = 3
            case "二分糖":
                sugarLevelSegmentedControl.selectedSegmentIndex = 4
            case "一分糖":
                sugarLevelSegmentedControl.selectedSegmentIndex = 5
            case "無糖":
                sugarLevelSegmentedControl.selectedSegmentIndex = 6
            default:
                print("sugar error")
            }
            
            let iceLevel = order.iceLevel
            switch iceLevel {
            case "正常冰":
                iceLevelSegmentedControl.selectedSegmentIndex = 0
            case "少冰":
                iceLevelSegmentedControl.selectedSegmentIndex = 1
            case "微冰":
                iceLevelSegmentedControl.selectedSegmentIndex = 2
            case "去冰":
                iceLevelSegmentedControl.selectedSegmentIndex = 3
            case "完全去冰":
                iceLevelSegmentedControl.selectedSegmentIndex = 4
            case "常溫":
                iceLevelSegmentedControl.selectedSegmentIndex = 5
            case "溫":
                iceLevelSegmentedControl.selectedSegmentIndex = 6
            case "熱":
                iceLevelSegmentedControl.selectedSegmentIndex = 7
            default:
                print("ice error")
            }
            
        } else {
            
            drinkDescriptionLabel.text = drinkDetail.drinkName + "：" + drinkDetail.drinkDescription
            
            sizeSegmentedControl.setTitle("中杯\(drinkDetail.mediumPrice)元", forSegmentAt: 0)
            
            if let largePrice = drinkDetail.largePrice {
                sizeSegmentedControl.setTitle("大杯\(largePrice)元", forSegmentAt: 1)
            } else {
                sizeSegmentedControl.setTitle("無提供大杯", forSegmentAt: 1)
                sizeSegmentedControl.setEnabled(false, forSegmentAt: 1)
            }
            
            doneBarButtonItem.isHidden = true
        }
        
        fetchImage()

        // Do any additional setup after loading the view.
    }
    
    func setSugarSementedControl() {
        for (index, data) in sugarLevels.enumerated() {
            sugarLevelSegmentedControl.setTitle(data, forSegmentAt: index)
        }
    }
    
    func setIceSementedControl() {
        for (index, data) in iceLevels.enumerated() {
            iceLevelSegmentedControl.setTitle(data, forSegmentAt: index)
        }
    }
    
    func fetchImage() {
        if let order = orderDetail {
            let drinkDetail = order.drinkDetail
            
            let url = drinkDetail.drinkImage
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data,
                   let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.drinkImageView.image = image
                    }
                }
            }.resume()
        } else {
            let url = drinkDetail.drinkImage
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data,
                   let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.drinkImageView.image = image
                    }
                }
            }.resume()
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if nameTextField.text?.isEmpty == false {
            return true
        } else {
            let alertController = UIAlertController(title: "操作錯誤", message: "請輸入訂購人姓名", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "確定", style: .default))
            
            present(alertController, animated: true)
            
            return false
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func dismissKeyboard(_ sender: UITextField) {
        view.endEditing(true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let order = orderDetail {
            let buyerName = nameTextField.text ?? ""
            
            var drinkSize: String = ""
            var drinkPrice: Int = 0
            if sizeSegmentedControl.selectedSegmentIndex == 0 {
                drinkSize = "中杯"
                drinkPrice = order.drinkDetail.mediumPrice
            } else {
                drinkSize = "大杯"
                drinkPrice = order.drinkDetail.largePrice ?? 0
            }
            
            let sugarLevel = getSugarLevel()
            //        let sugarLevel = SugarLevel.getSugarLevelName(sugarLevelSegmentedControl.selectedSegmentIndex)
            
            let iceLevel = getIceLevel()
            
            
            orderDetail = OrderDetail(buyerName: buyerName, drinkSize: drinkSize, drinkPrice: drinkPrice, sugarLevel: sugarLevel, iceLevel: iceLevel, drinkDetail: order.drinkDetail)
        } else {
            let buyerName = nameTextField.text ?? ""
            
            var drinkSize: String = ""
            var drinkPrice: Int = 0
            if sizeSegmentedControl.selectedSegmentIndex == 0 {
                drinkSize = "中杯"
                drinkPrice = drinkDetail.mediumPrice
            } else {
                drinkSize = "大杯"
                if let detail = drinkDetail {
                    drinkPrice = detail.largePrice ?? 0
                }
            }
            
            let sugarLevel = getSugarLevel()
            //        let sugarLevel = SugarLevel.getSugarLevelName(sugarLevelSegmentedControl.selectedSegmentIndex)
            
            let iceLevel = getIceLevel()
            
            
            orderDetail = OrderDetail(buyerName: buyerName, drinkSize: drinkSize, drinkPrice: drinkPrice, sugarLevel: sugarLevel, iceLevel: iceLevel, drinkDetail: drinkDetail)
        }
        
    }
    
    func getSugarLevel() -> String {
        switch sugarLevelSegmentedControl.selectedSegmentIndex {
        case 0:
            return "全糖"
        case 1:
            return "少糖"
        case 2:
            return "半糖"
        case 3:
            return "微糖"
        case 4:
            return "二分糖"
        case 5:
            return "一分糖"
        case 6:
            return "無糖"
        default:
            return ""
        }
    }
    
    func getIceLevel() -> String {
        switch iceLevelSegmentedControl.selectedSegmentIndex {
        case 0:
            return "正常冰"
        case 1:
            return "少冰"
        case 2:
            return "微冰"
        case 3:
            return "去冰"
        case 4:
            return "完全去冰"
        case 5:
            return "常溫"
        case 6:
            return "溫"
        case 7:
            return "熱"
        default:
            return ""
        }
    }
}
