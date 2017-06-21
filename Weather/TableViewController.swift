//
//  ViewController.swift
//  Weather
//
//  Created by Hung Nguyen on 5/28/17.
//  Copyright © 2017 com. All rights reserved.
//

import UIKit
import SwiftyJSON

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var weather: JSON = []
    
    @IBOutlet weak var timeZone: UILabel!
    @IBOutlet weak var currentSumary: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tempCurrent: UILabel!
    
    @IBOutlet weak var timeCurrent: UILabel!
    
    @IBOutlet weak var tempMin: UILabel!
    
    @IBOutlet weak var tempMax: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
        DataService.shared.requestAPI()
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: NSNotification.Name(rawValue: "1"), object: nil)
    }

    func handleNotification(_ notification: Notification) {
        weather = DataService.shared.weather
        timeZone.text = weather["timezone"].stringValue
        currentSumary.text = weather["currently"]["summary"].stringValue
        
        tempCurrent.text = String(Int(weather["currently"]["temperature"].doubleValue) - 32)
        timeCurrent.text = getWeekDay(timeInterval: weather["daily"]["data"][0]["time"].doubleValue)
        tempMin.text = String(describing: Int(weather["daily"]["data"][0]["temperatureMin"].doubleValue ) - 32)
        tempMax.text = String(describing: Int(weather["daily"]["data"][0]["temperatureMax"].doubleValue) - 32)
        tableView.reloadData()
    }
    
    func getWeekDay(timeInterval: TimeInterval) -> String{
        let dateFormatter = DateFormatter()
        let thatDay = Date(timeIntervalSince1970: timeInterval)
        dateFormatter.locale = Locale(identifier: "VI")
        let orderedDay = Calendar.current.component(.weekday, from: thatDay) - 1
        let weekDay = dateFormatter.weekdaySymbols[orderedDay]
        return weekDay
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weather["daily"]["data"].count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view: HeaderTBC = tableView.dequeueReusableCell(withIdentifier: "Header") as! HeaderTBC
        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == weather["daily"]["data"].count-1{
            tableView.rowHeight = 250
            let cell = tableView.dequeueReusableCell(withIdentifier: "Footer", for: indexPath) as! FooterTBC
            cell.temp.text = String(Int(weather["currently"]["temperature"].doubleValue) - 32)
            cell.humidity.text = String(Int(weather["currently"]["humidity"].doubleValue * 100)) + "%"
            cell.winSpeed.text = String(Int(weather["currently"]["winSpeed"].doubleValue * 100)) + "Km/h"
            cell.visibility.text = String(Int(weather["currently"]["visibility"].doubleValue)) + "km"
            return cell
        } else {
            tableView.rowHeight = 44
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell

            cell.weekDay.text = getWeekDay(timeInterval: weather["daily"]["data"][indexPath.row+1]["time"].doubleValue)
            cell.icon.image = UIImage(named: weather["daily"]["data"][indexPath.row+1]["icon"].stringValue + ".png")
            cell.tempMax.text = String(describing: Int(weather["daily"]["data"][indexPath.row+1]["temperatureMax"].doubleValue) - 32)
            cell.tempMin.text = String(describing: Int(weather["daily"]["data"][indexPath.row+1]["temperatureMin"].doubleValue) - 32)
            return cell
        }
    }
}



