//
//  WhiteListController.swift
//  projectZV
//
//  Created by Vika on 10/19/19.
//  Copyright © 2019 Vika. All rights reserved.
//
import UIKit

class WhiteListController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var whiteTable: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        whiteTable.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    // ak sender: Any iko, me UIButton vkeni
    @IBAction func addButtonTapped(_ sender: UIButton) {
        insertIntoWhiteList()
    }
 
    func insertIntoWhiteList() {
        guard let sender = textField.text else { return }
        
        Storage.instance.addToWhiteList(sender)
        
        let indexPath = IndexPath(row: Storage.instance.whiteList.count - 1, section: 0)
        
        whiteTable.beginUpdates()
        whiteTable.insertRows(at: [indexPath], with: .fade)
        whiteTable.endUpdates()
        textField.text = ""
        view.endEditing(true)
    }
}

extension WhiteListController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Storage.instance.whiteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WhiteListCell", for: indexPath)
        // init rom private ari araperi, xom?
        cell.textLabel?.text = Storage.instance.whiteList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Storage.instance.deleteFromWhiteList(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    
}
