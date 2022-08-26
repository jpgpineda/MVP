//
//  ClientPresenter.swift
//  MVPExample
//
//  Created by Javier Pineda Gonzalez on 12/08/22.
//

import Foundation
import UIKit

protocol ViewDelegate: AnyObject {
    func updateSchools(schools: [School])
    func presentLoader(isOn: Bool)
}

typealias PresenterDelegate = ViewDelegate & UIViewController

class ClientPresenter {
    weak var delegate: PresenterDelegate?
    
    public func getSchools() {
        delegate?.presentLoader(isOn: true)
        guard let url = URL(string: "http://universities.hipolabs.com/search?country=United+States") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            self?.delegate?.presentLoader(isOn: false)
            if let error = error {
                print("Hubo un error \(error.localizedDescription)")
            } else {
                guard let data = data else {
                    return
                }
                do {
                    let schools = try JSONDecoder().decode([School].self, from: data)
                    self?.delegate?.updateSchools(schools: schools)
                } catch {
                    print("Hubo un error en el decode \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
    
    public func setViewDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
    
    public func didTap(school: School) {
        let title = "Precaucion"
        let message = "\(school.name) ha sido seleccionado"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        delegate?.present(alert, animated: true, completion: nil)
    }
}
