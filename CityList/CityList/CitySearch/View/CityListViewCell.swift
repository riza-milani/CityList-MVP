//
//  CityListViewCell.swift
//  CityList
//
//  Created by riza milani on 5/17/1398 AP.
//  Copyright © 1398 riza milani. All rights reserved.
//

import UIKit

class CityListViewCell: UITableViewCell {

    private var cellTitle: UILabel!
    private var cellSubTitle: UILabel!
    private var cellInfoButton: UIButton!
    var presenter: CityListPresenterProtocol?
    var city: City! {
        didSet {
            cellTitle.text = "\(city.name), \(city.country)"
            cellSubTitle.text = "Longitude: \(city.coord.lon), Latitude: \(city.coord.lat)"
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: 100))
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 80).isActive = true

        cellTitle = UILabel()
        cellTitle.text = "City, Country"
        cellTitle.textAlignment = .left
        cellTitle.font = UIFont.boldSystemFont(ofSize: 18)
        containerView.addSubview(cellTitle)
        cellTitle.translatesAutoresizingMaskIntoConstraints = false
        cellTitle.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        cellTitle.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16).isActive = true
        cellTitle.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -16).isActive = true

        cellSubTitle = UILabel()
        cellSubTitle.text = "Coordinates"
        cellSubTitle.textAlignment = .left
        cellSubTitle.font = cellSubTitle.font.withSize(14)
        cellSubTitle.textColor = .lightGray
        containerView.addSubview(cellSubTitle)
        cellSubTitle.translatesAutoresizingMaskIntoConstraints = false
        cellSubTitle.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        cellSubTitle.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16).isActive = true
        cellSubTitle.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 16).isActive = true
        
        cellInfoButton = UIButton(type: .system)
        cellInfoButton.setTitle("i", for: .normal)
        cellInfoButton.setTitleColor(.white, for: .normal)
        cellInfoButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        cellInfoButton.backgroundColor = #colorLiteral(red: 0.419321835, green: 0.6123344302, blue: 0.8921020627, alpha: 1)
        containerView.addSubview(cellInfoButton)
        cellInfoButton.translatesAutoresizingMaskIntoConstraints = false
        cellInfoButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16).isActive = true
        cellInfoButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        cellInfoButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        cellInfoButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        cellInfoButton.layer.cornerRadius = 20
        cellInfoButton.addTarget(self, action: #selector(infoButtonAction(view:)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension CityListViewCell {

    @objc
    func infoButtonAction(view: UIButton) {
        presenter?.showAboutInfo()
    }
}
