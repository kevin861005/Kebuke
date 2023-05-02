//
//  DrinkDetailViewController.swift
//  Kebuke
//
//  Created by NAI LUN CHEN on 2023/4/26.
//

import UIKit

class DrinkDetailViewController: UIViewController {
    
    var drinkDetail: DrinkDetail!

    @IBOutlet weak var drinkIntroduction: UILabel!
    @IBOutlet weak var drinkImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drinkIntroduction.text = drinkDetail.drinkIntroduction
        
        drinkImage.image = UIImage(named: "可不可LOGO")
        
        fetchImage()
        // Do any additional setup after loading the view.
    }
    
    func fetchImage() {
        let url = drinkDetail.drinkImage
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data,
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.drinkImage.image = image
                }
            }
        }.resume()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
