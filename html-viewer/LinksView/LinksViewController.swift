//
//  SecondViewController.swift
//  html-viewer
//
//  Created by Zoic on 25/05/2019.
//  Copyright © 2019 v.lumelskiy. All rights reserved.
//

import UIKit

class LinksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBAction func addButton(_ sender: Any) {
        present(myAlertController(), animated: true, completion: nil)
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    let myModal = ModalViewController()
    
    // +++++++++++++++++++++++++++++++++++++++++++++++++++
    // +++++++++++++++++++++++++++++++++++++++++++++++++++
    // Событие при загрузке ячейки
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    // +++++++++++++++++++++++++++++++++++++++++++++++++++
    // +++++++++++++++++++++++++++++++++++++++++++++++++++
    // Событие при ошибке памяти
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // +++++++++++++++++++++++++++++++++++++++++++++++++++
    // +++++++++++++++++++++++++++++++++++++++++++++++++++
    // Контроллер алерта для добавления / изменения ссылок
    func myAlertController(index: Int? = nil) -> UIAlertController {
        
        var main_title = "Добавить ссылку"
        var button_title = "Добавить"
        
        if (index != nil) {
            main_title = "Изменить ссылку"
            button_title = "Изменить"
        }
        
        // контроллер
        let alertController = UIAlertController(title: main_title, message: nil, preferredStyle: .alert)
        // кнопки
        let alertActionCancel = UIAlertAction(title: "Отмена", style: .default, handler: nil)
        let alertAction = UIAlertAction(title: button_title, style: .default) { (alert) in
            // здесь нужно сделать проверку данных alertController.textFields!
            let item = ["title": (alertController.textFields![0].text ?? "Yandex"), "link": (alertController.textFields![1].text ?? "https://yandex.ru")]
            if (index != nil) {
                editLinkItem(at: index!, item: item)
            } else {
                addLinkItem(item: item)
            }
            self.tableView.reloadData();
        }
        // добавляем кнопки
        alertController.addAction(alertActionCancel)
        alertController.addAction(alertAction)
        // добавляем текстовые поля
        alertController.addTextField { (TextField) in
            TextField.placeholder = "Название"
            if (index != nil) {
                TextField.text = LinksItemsObject[index!]["title"] as? String
            }
        }
        alertController.addTextField { (TextField) in
            TextField.placeholder = "Ссылка"
            if (index != nil) {
                TextField.text = LinksItemsObject[index!]["link"] as? String
            }
        }
        // показываем его
        return alertController
    }
    
    
    // +++++++++++++++++++++++++++++++++++++++++++++++++++
    // +++++++++++++++++++++++++++++++++++++++++++++++++++
    // Обработка нажатия на ячейку
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let link = LinksItemsObject[indexPath.row]["link"] as! String
        
        myModal.modalPresentationStyle = .fullScreen
        present(myModal, animated: true, completion: {
            self.myModal.webView.load(URLRequest(url: URL(string: link)!))
        })

    }
    
    // +++++++++++++++++++++++++++++++++++++++++++++++++++
    // +++++++++++++++++++++++++++++++++++++++++++++++++++
    // Определение параметров таблицы (количество секций)
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    // +++++++++++++++++++++++++++++++++++++++++++++++++++
    // +++++++++++++++++++++++++++++++++++++++++++++++++++
    // Определение параметров таблицы (количество строчек)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return LinksItemsObject.count
    }
    
    // +++++++++++++++++++++++++++++++++++++++++++++++++++
    // +++++++++++++++++++++++++++++++++++++++++++++++++++
    // Override для определения заполнения ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LinkCell", for: indexPath)
        // Configure the cell...
        let item = LinksItemsObject[indexPath.row]
        cell.textLabel?.text = item["title"] as? String
        
        return cell
    }
    
    // +++++++++++++++++++++++++++++++++++++++++++++++++++
    // +++++++++++++++++++++++++++++++++++++++++++++++++++
    // Override для поддержки редактирования ячеек в table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // +++++++++++++++++++++++++++++++++++++++++++++++++++
    // +++++++++++++++++++++++++++++++++++++++++++++++++++
    // Override для определения редактирования ячейки таблицы по ее indexPath.
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
            removeLinkItem(at: indexPath.row) // нужно обновить переменную с данными чтобы изменилась длинна отображаемого массив
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
            // edit item at indexPath
            self.present(self.myAlertController(index: indexPath.row), animated: true, completion: nil)
        }
        
        edit.backgroundColor = UIColor.blue
        
        return [delete, edit]
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
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */


}

