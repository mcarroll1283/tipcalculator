//
//  SettingsViewController.swift
//  tips
//
//  Created by Matthew Carroll on 4/5/15.
//  Copyright (c) 2015 blarg. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var defaultTipPercentageControl: UISegmentedControl!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        let defaults = NSUserDefaults.standardUserDefaults()
        let maybeStoredSegment = defaults.objectForKey("default_tip_percentage_segment")
        if let storedSegment = maybeStoredSegment {
            let storedSegmentInt = storedSegment as Int
            defaultTipPercentageControl.selectedSegmentIndex = storedSegmentInt
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onDismissTouched(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onPercentageControlChanged(sender: UISegmentedControl) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(defaultTipPercentageControl.selectedSegmentIndex, forKey: "default_tip_percentage_segment")
        defaults.synchronize()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
