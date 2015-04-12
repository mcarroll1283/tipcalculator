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
    
    @IBOutlet weak var tipControlLabel: UILabel!

    @IBOutlet weak var themeControl: UISegmentedControl!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var themeControlLabel: UILabel!
    
    @IBOutlet weak var okButton: UIButton!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        let defaults = NSUserDefaults.standardUserDefaults()
        
        let maybePercentSegment = defaults.objectForKey("default_tip_percentage_segment") as Int?
        if let percentSegment = maybePercentSegment {
            defaultTipPercentageControl.selectedSegmentIndex = percentSegment
        }
        
        let maybeThemeSegment = defaults.objectForKey("theme") as Int?
        if let themeSegment = maybeThemeSegment {
            themeControl.selectedSegmentIndex = themeSegment
        }
        
        let maybeTheme = defaults.objectForKey("theme") as Int?
        if let theme = maybeTheme {
            applyTheme(theme)
        } else {
            applyTheme(0)
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
    
    @IBAction func onThemeControlChanged(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(themeControl.selectedSegmentIndex, forKey: "theme")
        defaults.synchronize()
    }
    
    private func applyTheme(theme: Int) {
        let white = UIColor.whiteColor()
        let gray = UIColor.grayColor()
        let black = UIColor.blackColor()
        let green = UIColor(red:0.31, green:0.73, blue:0.27, alpha:1)
        switch theme {
        case 0:
            view.backgroundColor = white
            titleLabel.textColor = black
            tipControlLabel.textColor = black
            themeControlLabel.textColor = black
            okButton.tintColor = green
            defaultTipPercentageControl.tintColor = green
            themeControl.tintColor = green
        case 1:
            view.backgroundColor = UIColor.darkGrayColor()
            titleLabel.textColor = white
            tipControlLabel.textColor = white
            themeControlLabel.textColor = white
            okButton.tintColor = white
            defaultTipPercentageControl.tintColor = gray
            themeControl.tintColor = gray
        default:
            print("Unknown theme: \(theme)")
        }
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
