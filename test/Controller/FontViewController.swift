//
//  FontViewController.swift
//  test
//
//  Created by Antarpunit Singh on 2012-07-23.
//  Copyright © 2019 AntarpunitSingh. All rights reserved.
//

import UIKit

class FontViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    

    @IBOutlet weak var tableView: UITableView!
    lazy var font = Fetch.font
    
    var delegate: TextDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return font.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FontCell", for: indexPath)
        
        cell.textLabel?.text = font[indexPath.row]
        cell.textLabel?.font = UIFont(name: font[indexPath.row], size: 20)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.updateLabelText(value: font[indexPath.row])
    }
}
