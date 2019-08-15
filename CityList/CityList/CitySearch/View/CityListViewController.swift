//
//  CityListViewController.swift
//  CityList
//
//  Created by riza milani on 5/17/1398 AP.
//  Copyright © 1398 riza milani. All rights reserved.
//

import UIKit

protocol CityListViewControllerProtocol: class {
    /// This is delegate that called in presenter after fetching and filtering cities.
    func dataDidLoad(cities: [City])
    /// It was better to implement this function in a base protocol, so other controllers can access it.
    /// But in this case I keep it here
    func showErrorMessage(string: String)
}

class CityListViewController: UIViewController, CityListViewControllerProtocol {

    private var tableView: UITableView!
    private var searchBar: UISearchBar!
    private var activityIndicatorView: UIActivityIndicatorView!
    var presenter: CityListPresenterProtocol?
    var cities: [City] = [] {
        didSet {
            tableView.reloadData()
            if !cities.isEmpty {
                let indexPath = IndexPath(row: 0, section: 0)
                tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "City List"
        createSearchBar()
        createTableView()
        presenter?.fetchData { [weak self] cities in
            if cities.isEmpty {
                self?.showErrorMessage(string: "Couldn't fetch data")
            } else {
                self?.dataDidLoad(cities: cities)
            }
        }
        
    }
}

extension CityListViewController {

    // MARK: - Create search bar
    func createSearchBar() {
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.autocapitalizationType = .none
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.showsCancelButton = true
        // Wait until data loaded.
        searchBarEnabled(state: false)
        view.addSubview(searchBar)

        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        searchBar.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0).isActive = true
    }

    func createTableView() {
        tableView = UITableView()
        tableView.register(CityListViewCell.self, forCellReuseIdentifier: String(describing: CityListViewCell.self))
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        view.addSubview(tableView)

        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true

        let activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        activityIndicatorView.color = .gray
        tableView.backgroundView = activityIndicatorView
        self.activityIndicatorView = activityIndicatorView
        activityIndicatorView.startAnimating()
    }
}

extension CityListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CityListViewCell.self)) as? CityListViewCell else {
            return UITableViewCell()
        }
        cell.presenter = presenter
        cell.city = cities[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coord = cities[indexPath.row].coord
        presenter?.showMap(coord: coord)
    }
    
}

// MARK: - view controller delegete implementation
extension CityListViewController {
    func dataDidLoad(cities: [City]) {
        DispatchQueue.main.async {
            self.searchBarEnabled(state: true)
            self.activityIndicatorView.stopAnimating()
            self.cities = cities
        }
    }

    func showErrorMessage(string: String) {
        // Reused function
        let alertController = UIAlertController(title: "Error",
                                                message: string,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: - search bar delegate
extension CityListViewController: UISearchBarDelegate {

    func searchBarEnabled(state: Bool) {
        if state {
            searchBar.isUserInteractionEnabled = true
            searchBar.placeholder = "Filter cities by name ..."
        } else {
            searchBar.isUserInteractionEnabled = false
            searchBar.placeholder = "Please wait while loading ..."
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.filterCity(startWith: searchText) { [weak self] cities in
            if cities.isEmpty {
                self?.showErrorMessage(string: "Couldn't fetch data")
            } else {
                self?.dataDidLoad(cities: cities)
            }
        }
    }
}
