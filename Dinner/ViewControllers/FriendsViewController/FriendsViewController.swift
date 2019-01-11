//
//  FriendsViewController.swift
//  Dinner
//
//  Created by JORGE VAZQUEZ REQUEJO on 11/1/19.
//  Copyright © 2019 JORGE VAZQUEZ REQUEJO. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    internal var tasks: [Task]!
    var tasksSearch: [Task]!
    internal var repository = LocalTaskRepository()
    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Mis Tareas"
        registerCell()
        tasks = repository.getAll()
        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPressed))
        navigationItem.setRightBarButton(addBarButtonItem, animated: false)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Buscar Pagados (Si/No) ..."
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    convenience init(tasks:[Task]){
        self.init()
        self.tasks = tasks
    }
    
    internal func searchBarIsEmpty() -> Bool{
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    internal func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    internal func filterContentForSearchText(_ searchText: String){
        tasksSearch = tasks.filter({ (aTask: Task ) -> Bool in
            return (aTask.pay.lowercased().contains(searchText.lowercased()))
        })
        tableView.reloadData()
    }
    @objc internal func addPressed(){
        let addVC = AddViewController(task: nil)
        addVC.delegate = self
        addVC.modalTransitionStyle = .coverVertical
        addVC.modalPresentationStyle = .overCurrentContext
        present(addVC, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    internal func registerCell(){
        let nib = UINib(nibName: "TaskCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TaskCell")
    }
    
}

extension FriendsViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering(){
            return tasksSearch.count
        }
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TaskCell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
        if isFiltering(){
            let task = tasksSearch[indexPath.row]
            cell.nameLabel.text = task.name
            cell.lblPay.text = task.pay
            return cell
        }else{
            let task = tasks[indexPath.row]
            cell.nameLabel.text = task.name
            cell.lblPay.text = task.pay
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = tasks[indexPath.row]
        
        if repository.delete(a: task){
            tasks.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
        let editVC = AddViewController()
        navigationController?.pushViewController(editVC, animated: true)
        
        func addViewController(_ vc: AddViewController, didEditTask task: Task) {
            vc.dismiss(animated: true, completion: nil)
            if repository.create(a: task){
                tasks = repository.getAll()
                tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let task = tasks[indexPath.row]
            if repository.delete(a: task){
                tasks.remove(at: indexPath.row)
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.endUpdates()
            }
        }
    }
}

extension FriendsViewController: AddViewControllerDelegate{
    func addViewController(_ vc: AddViewController, didEditTask task: Task) {
        vc.dismiss(animated: true, completion: nil)
        if repository.create(a: task){
            tasks = repository.getAll()
            tableView.reloadData()
        }
    }
}
extension FriendsViewController:UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
