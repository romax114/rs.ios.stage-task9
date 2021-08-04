//
//  ChooseColorViewController.swift
//  RSSchool_T9
//
//  Created by Нехай Роман 8/4/21.
//

import UIKit

@objc class ChooseColorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    let tableView: UITableView = UITableView()
    let colorsArray: Array<String> = ["#be2813",
                                      "#3802da",
                                      "#467c24",
                                      "#808080",
                                      "#8e5af7",
                                      "#f07f5a",
                                      "#f3af22",
                                      "#3dacf7",
                                      "#e87aa4",
                                      "#0f2e3f",
                                      "#213711",
                                      "#511307",
                                      "#92003b"]
    var choosenColor: String?
   @objc var state: PaintingState?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "SettingsViewBackground")
        configureView()
        configureTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func configureView() {
        self.navigationItem.leftBarButtonItem?.tintColor = .red
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "colorCell")
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
    }
    
    func configureTableView() {
        tableView.layer.cornerRadius = 16
        self.tableView.alwaysBounceVertical = false;
        self.tableView.isScrollEnabled = false;
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 123).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: 572).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colorsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "colorCell", for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = colorsArray[indexPath.row]
        cell.textLabel?.font = UIFont(name: "SFProDisplay-Regular", size: 17)
        cell.textLabel?.textColor = UIColor(hexString: colorsArray[indexPath.row])
        let choosenImg = UIImageView(image: UIImage(systemName: "checkmark"))
        choosenImg.tintColor = .red
        choosenImg.contentMode = .scaleAspectFit
        cell.contentView.addSubview(choosenImg)
        if state?.color == colorsArray[indexPath.row] {
            choosenImg.isHidden = false
        } else {
            choosenImg.isHidden = true
        }
        choosenImg.translatesAutoresizingMaskIntoConstraints = false
        choosenImg.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -22.5).isActive = true
        choosenImg.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor).isActive = true
        choosenImg.heightAnchor.constraint(equalToConstant: 32).isActive = true
        choosenImg.widthAnchor.constraint(equalToConstant: 18).isActive = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        state?.color = colorsArray[indexPath.row]
        _ = navigationController?.popViewController(animated: true)
    }
}
