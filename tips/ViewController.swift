//
//  ViewController.swift
//  tips
//
//  Created by Matthew Carroll on 4/4/15.
//  Copyright (c) 2015 blarg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var billField: UITextField!
    
    @IBOutlet weak var billFieldLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBOutlet weak var tipControlLabel: UILabel!
    
    @IBOutlet weak var tipTextLabel: UILabel!
    
    @IBOutlet weak var totalTextLabel: UILabel!
    
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00 "
    }
    
    override func viewWillAppear(animated: Bool) {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let maybeStoredSegment = defaults.objectForKey("default_tip_percentage_segment") as Int?
        if let storedSegment = maybeStoredSegment {
            tipControl.selectedSegmentIndex = storedSegment
        }
        
        let maybeLastBillEdit = defaults.objectForKey("last_bill_edit") as Double?
        if let lastBillEdit = maybeLastBillEdit {
            let lastBillEditDate = NSDate(timeIntervalSinceReferenceDate: lastBillEdit)
            let tenMinutesAgo = NSDate(timeIntervalSinceNow: -1 * 60 * 10)
            if tenMinutesAgo.earlierDate(lastBillEditDate) == tenMinutesAgo {
                let maybeStoredBill = defaults.objectForKey("stored_bill") as String?
                if let storedBill = maybeStoredBill {
                    billField.text = storedBill
                    updateTipAndTotalFields()
                }
            }
        }
        
        let maybeTheme = defaults.objectForKey("theme") as Int?
        if let theme = maybeTheme {
            applyTheme(theme)
        } else {
            applyTheme(0)
        }
    }
    
    private func applyTheme(theme: Int) {
        let white = UIColor.whiteColor()
        let gray = UIColor.grayColor()
        let black = UIColor.blackColor()
        let green = UIColor(red:0.31, green:0.73, blue:0.27, alpha:1)
        let darkGray = UIColor.darkGrayColor()
        
        switch theme {
        case 0:
            view.backgroundColor = white
            tipLabel.textColor = black
            billField.textColor = black
            billField.backgroundColor = white
            billFieldLabel.textColor = black
            totalLabel.textColor = black
            tipControlLabel.textColor = black
            tipControl.tintColor = green
            tipTextLabel.textColor = black
            totalTextLabel.textColor = black
            settingsButton.tintColor = green
        case 1:
            view.backgroundColor = darkGray
            tipLabel.textColor = white
            billField.textColor = white
            billField.backgroundColor = gray
            billFieldLabel.textColor = white
            totalLabel.textColor = white
            tipControlLabel.textColor = white
            tipControl.tintColor = gray
            tipTextLabel.textColor = white
            totalTextLabel.textColor = white
            settingsButton.tintColor = darkGray
        default:
            print("Unknown theme: \(theme)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        updateTipAndTotalFields()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(billField.text, forKey: "stored_bill")
        let now = NSDate()
        defaults.setObject(now.timeIntervalSinceReferenceDate, forKey: "last_bill_edit")
    }
    
    private func updateTipAndTotalFields() {
        let tipPercentages = [0.18, 0.2, 0.22]
        let tipPercent = tipPercentages[tipControl.selectedSegmentIndex]
        let billAmount = (billField.text as NSString).doubleValue
        let tip = billAmount * tipPercent
        let total = billAmount + tip
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        tipLabel.text = formatter.stringFromNumber(tip)
        totalLabel.text = formatter.stringFromNumber(total)
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}

