//
//  CitySearchRouter.swift
//  CityList
//
//  Created by riza milani on 5/17/1398 AP.
//  Copyright © 1398 riza milani. All rights reserved.
//

import UIKit

class CityListRouter {

    var cityListViewController: UIViewController?
    var cityMapViewController: UIViewController?
    var splitViewController: UISplitViewController?

    func assembleModule() -> UIViewController {
        let splitViewController =  SplitViewController()
        let cityListViewController = CityListViewController()
        let cityMapViewController = CityMapViewController()
        let presenter = CityListPresenter()
        
        presenter.router = self

        cityListViewController.presenter = presenter
        
        let masterNavigationController = UINavigationController(rootViewController: cityListViewController)
        let detailNavigationController = UINavigationController(rootViewController: cityMapViewController)
        splitViewController.viewControllers = [masterNavigationController,detailNavigationController]
        self.cityListViewController = cityListViewController
        self.cityMapViewController = cityMapViewController
        self.splitViewController = splitViewController
        return splitViewController
    }

    func showAboutInfo() {
        let aboutViewController = AboutViewController()
        let presenter = AboutPresenter(view: aboutViewController, model: Model())
        aboutViewController.presenter = presenter
        cityListViewController?.navigationController?.pushViewController(aboutViewController, animated: true)
    }

    func showMap(coord: Coord) {
        guard let cityMapViewController = cityMapViewController as? CityMapViewController else {
            return
        }
        cityMapViewController.coordinator = coord
        splitViewController?.showDetailViewController(cityMapViewController, sender: nil)
    }
}
