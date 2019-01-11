//
//  AddViewController.swift
//  Dinner
//
//  Created by JORGE VAZQUEZ REQUEJO on 11/1/19.
//  Copyright © 2019 JORGE VAZQUEZ REQUEJO. All rights reserved.
//

import UIKit

protocol AddViewControllerDelegate: class {
    func addViewController(_ vc: AddViewController, didEditTask task: Task)
}

class AddViewController: UIViewController {
    
    @IBOutlet var viewBack: UIView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var txtPay: UITextField!
    internal var task: Task!
    weak var delegate: AddViewControllerDelegate!
    
    convenience init(task: Task?){
        self.init()
        if task == nil{
            self.task = Task()
            self.task.name = UUID().uuidString
            self.task.pay = ""
        }else{
            self.task = task
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.8){
            self.view.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewBack.layer.cornerRadius = 8.0
        viewBack.layer.masksToBounds = true
        saveButton.layer.cornerRadius = 8.0
        saveButton.layer.masksToBounds = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func closeButtonPressed(){
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(){
        self.task.name = textField.text
        self.task.pay = txtPay.text
        delegate.addViewController(self, didEditTask: task)
    }
    
}

