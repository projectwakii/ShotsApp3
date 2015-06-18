//
//  Home.swift
//  ShotsApp2
//
//  Created by David Liu on 17/06/2015.
//  Copyright © 2015 David Liu. All rights reserved.
//

import UIKit

class Home: UIViewController {
    
    @IBOutlet weak var userButton: UIButton!
    @IBAction func userButtonDidPress(sender: AnyObject) {
        print("User button pressed.")
        
        //popoverView is initially hidden. This is something that can be switched on/off in the Attributes inspector, after selecting Popover View in Interface Builder.
        //To show the popoverView, simply type popoverView.hidden = false.
        
        popoverView.hidden = false
        
        //By using popoverView.hidden = !popoverView.hidden, we flip the bool value to the opposite of what it already is (e.g. true --> false)
        // popoverView.hidden = !popoverView.hidden
        
    }
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    
    @IBOutlet weak var backgroundMaskView: UIView!
    
    @IBOutlet weak var dialogView: UIView!
    
    @IBOutlet weak var imageButton: UIButton!
    @IBAction func imageButtonDidPress(sender: AnyObject) {
        print("Image button pressed.")
        
        /*
        UIView.animateWithDuration(0.5, animations: {
        }
        */
        
        
            UIView.animateWithDuration(0.5, animations: {
                
                //1. dialogView.frame expects a CGRect.
                //We're getting the detailView to fill the entire screen (320x568).
                self.dialogView.frame = CGRectMake(0, 0, 320, 568)
                
                //2. DialogView fills the entire screen, but we need to make the Like and Share buttons disappear, as well as the UserButton.
                self.likeButton.hidden = true
                self.shareButton.hidden = true
                self.userButton.hidden = true
                // "self.headerView.hidden = true" is sufficient, but here we'll use the alpha instead, so that it doesn't disappear instantly but instead is animated gradually until it disappears.
                self.headerView.alpha = 0
                
                //3. We need to expand the original image to fill the screen. Simultaneously, we'll get rid of the round corners.
                self.imageButton.frame = CGRectMake(0, 0, 320, 250)
                self.imageButton.layer.cornerRadius = 0

                
                }, completion: {
                    //4. This completion allows us to complete the segue and end up in the detail view.
                    finished in self.performSegueWithIdentifier("homeToDetail", sender: self)
                    
            })
    }
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var favoritesLabel: UIImageView!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBAction func likeButtonDidPress(sender: AnyObject) {
        print("Like button pressed.")
    }
    
    @IBOutlet weak var shareButton: UIButton!
    @IBAction func shareButtonDidPress(sender: AnyObject) {
        print("Share button pressed.")
        shareView.hidden = false
        
        //Makes backgroundMaskView blur the background.
        insertBlurView(backgroundMaskView, style: UIBlurEffectStyle.Dark)
        
        self.shareView.alpha = 0
        //Memorize this. 
        UIView.animateWithDuration(0.5, animations: {
            self.shareView.alpha = 1
        })
    }
    
    
    
    
    
    @IBOutlet weak var popoverView: UIView!
    @IBOutlet weak var shareView: UIView!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        //This changes the UI Status Bar to be white.
        return UIStatusBarStyle.LightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
