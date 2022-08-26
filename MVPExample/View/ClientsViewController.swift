//
//  ClientsViewController.swift
//  MVPExample
//
//  Created by Javier Pineda Gonzalez on 12/08/22.
//

import UIKit
import Lottie

class ClientsViewController: UIViewController {

    @IBOutlet weak var loadingAnimation: AnimationView!
    @IBOutlet weak var clientsTable: UITableView!
    
    private let presenter = ClientPresenter()
    private var clients: [ClientModel] = [ClientModel]()
    private var schools: [School] = [School]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // table view
        clientsTable.dataSource = self
        clientsTable.delegate = self
        
        // Animation
        loadingAnimation.loopMode = .loop
        loadingAnimation.contentMode = .scaleAspectFit
        loadingAnimation.play()

        // presenter
        presenter.setViewDelegate(delegate: self)
        presenter.getSchools()
    }
}

extension ClientsViewController: ViewDelegate {
    func presentLoader(isOn: Bool) {
        DispatchQueue.main.async {
            self.loadingAnimation.isHidden = !isOn
        }
    }
    
    func updateSchools(schools: [School]) {
        self.schools = schools
        DispatchQueue.main.async {
            self.clientsTable.reloadData()
        }
    }
}

extension ClientsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schools.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "clientCell", for: indexPath)
        var listConfiguration = UIListContentConfiguration.cell()
        let school = schools[indexPath.row]
        listConfiguration.text = school.name + " " + school.country
        cell.contentConfiguration = listConfiguration
        return cell
    }
}

extension ClientsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didTap(school: schools[indexPath.row])
    }
}
