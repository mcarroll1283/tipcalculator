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
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    
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
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}

