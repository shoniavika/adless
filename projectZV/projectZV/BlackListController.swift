//
//  BlackListController.swift
//  projectZV
//
//  Created by Vika on 10/20/19.
//  Copyright © 2019 Vika. All rights reserved.
//

import UIKit

class BlackListController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var blackTable: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blackTable.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    @IBAction func addToBlackList(_ sender: UIButton) {
            insertIntoBlackList()
    }
    
    func insertIntoBlackList() {
        guard let sender = textField.text else { return }
        
        Storage.instance.addToBlackList(sender)
        
        let indexPath = IndexPath(row: Storage.instance.whiteList.count - 1, section: 0)
        
        blackTable.beginUpdates()
        blackTable.insertRows(at: [indexPath], with: .fade)
        blackTable.endUpdates()
        textField.text = ""
        view.endEditing(true)
    }
}

extension BlackListController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Storage.instance.blackList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BlackListCell", for: indexPath)
        // init rom private ari araperi, xom?
        cell.textLabel?.text = Storage.instance.blackList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Storage.instance.deleteFromBlackList(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
}
