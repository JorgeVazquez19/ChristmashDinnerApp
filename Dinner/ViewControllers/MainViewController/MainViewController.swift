//
//  MainViewController.swift
//  Dinner
//
//  Created by JORGE VAZQUEZ REQUEJO on 11/1/19.
//  Copyright © 2019 JORGE VAZQUEZ REQUEJO. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var btnFriends: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func showTable(){
        let tableSV = FriendsViewController()
        let navigationController = UINavigationController(rootViewController: tableSV)
        navigationController.modalTransitionStyle = .flipHorizontal
        present(navigationController, animated: true, completion: nil)
    }
    @IBAction func ActionFriends(_ sender: UIButton){
        showTable()
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

