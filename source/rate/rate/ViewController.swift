//
//  ViewController.swift
//  rate
//
//  Created by kevin on 2019/11/7.
//  Copyright © 2019 kevin. All rights reserved.
//

import UIKit
import Alamofire
import Kanna
import WebKit

class ViewController: UIViewController, UINavigationBarDelegate, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    
    var flag = ["USD": "🇺🇸", "HKD": "🇭🇰", "GBP": "🇬🇧", "AUD": "🇦🇺", "CAD": "🇨🇦", "SGD": "🇸🇬", "CHF": "🇨🇭", "JPY": "🇯🇵", "ZAR": "🇿🇦", "SEK": "🇸🇪", "NZD": "🇳🇿", "THB": "🇹🇭", "PHP": "🇵🇭", "IDR": "🇮🇩", "EUR": "🇪🇺", "KRW": "🇰🇷", "VND": "🇻🇳", "MYR": "🇲🇾", "CNY": "🇨🇳"]
    var currency = [String]()
    var currency_EN = [String]()
    var buy = [[String]]()
    var sell = [[String]]()
    var cashspot = 0
    let _chartURL = "https://rate.bot.com.tw/xrt/quote/ltm/"
    var chartURL : String = ""
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currency_EN.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RateTableViewCell
        cell.currencyLabel.text = currency[indexPath.row]
        cell.flagLabel.text = flag[currency_EN[indexPath.row]]!
        var str: String
        if cashspot == 0 {
            str = "現金"
        } else {
            str = "即期"
        }
        cell.buyLabel.text = str + "買入 : " + buy[Int(indexPath.row)][cashspot]
        cell.sellLabel.text = str + "賣出 : " + sell[Int(indexPath.row)][cashspot]
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let page2 = segue.destination as! WebViewController
        chartURL = _chartURL + currency_EN[tableView.indexPathForSelectedRow!.row] + "?Lang=zh-TW"
        tableView.deselectRow(at: (tableView.indexPathForSelectedRow)!, animated: false)
        page2.url = chartURL
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "https://rate.bot.com.tw/xrt?Lang=zh-TW"
        Alamofire.request(url).responseString { response in
            if let html = response.result.value {
                self.parseTaiwanBankHTML(html: html)

                self.tableView.estimatedRowHeight = 91;
                self.tableView.endUpdates()
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func mySegmentedAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            cashspot = 0
            self.tableView.reloadData()
        }else {
            cashspot = 1
            self.tableView.reloadData()
        }
    }
    
    func parseTaiwanBankHTML(html: String) {
        print("Alamofire")
        
        do{
            if let doc = try? Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
                
                for i in 1...19 {
                    
                    var str = doc.xpath("/html/body/div[1]/main/div[3]/table/tbody/tr[\(i)]/td[1]/div/div[2]").first!.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    currency.append(str)
                    str = String(str.suffix(4))
                    str = String(str.prefix(3))
                    currency_EN.append(str)
                    
                    buy.append([doc.xpath("/html/body/div[1]/main/div[3]/table/tbody/tr[\(i)]/td[2]").first!.text!.trimmingCharacters(in: .whitespacesAndNewlines), doc.xpath("/html/body/div[1]/main/div[3]/table/tbody/tr[\(i)]/td[4]").first!.text!.trimmingCharacters(in: .whitespacesAndNewlines)])
                    
                    sell.append([doc.xpath("/html/body/div[1]/main/div[3]/table/tbody/tr[\(i)]/td[3]").first!.text!.trimmingCharacters(in: .whitespacesAndNewlines), doc.xpath("/html/body/div[1]/main/div[3]/table/tbody/tr[\(i)]/td[5]").first!.text!.trimmingCharacters(in: .whitespacesAndNewlines)])
                }
            }
        } catch {
            print(error)
        }
    }
    
}

