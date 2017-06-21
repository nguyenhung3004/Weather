//
//  CollectionView.swift
//  Weather
//
//  Created by Hung Nguyen on 5/28/17.
//  Copyright © 2017 com. All rights reserved.
//

import UIKit

class HeaderTBC: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func stringFromTimeInterval(interval: TimeInterval) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "Your date Format"
        let date = Date(timeIntervalSince1970: interval)
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.hour], from: date)
        let hour = comp.hour
        return hour!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataService.shared.weather["hourly"]["data"].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "Item", for: indexPath as IndexPath) as! CollectionViewCell
        item.hour.text = String(describing: stringFromTimeInterval(interval: DataService.shared.weather["hourly"]["data"][indexPath.row]["time"].doubleValue))
        item.icon.image = UIImage(named: DataService.shared.weather["hourly"]["data"][indexPath.row]["icon"].stringValue + ".png")
        item.temp.text = String(describing: Int(DataService.shared.weather["hourly"]["data"][indexPath.row]["temperature"].doubleValue) - 32)  + "C"
        return item
    }

}
