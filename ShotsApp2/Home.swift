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
        
        /*
        //~~~~~~~TRANSFORM~~~~~~~~
        //1. Set initial settings for popoverView.
        
            let scale = CGAffineTransformMakeScale(0.3, 0.3)
            let translate = CGAffineTransformMakeTranslation(200, -200)
            
            self.popoverView.transform = CGAffineTransformConcat(scale, translate)
        
        //2. Animate it on press.
        UIView.animateWithDuration(0.5, animations: {
                let scale = CGAffineTransformMakeScale(1, 1)
                let translate = CGAffineTransformMakeTranslation(0, 0)
                
                self.popoverView.transform = CGAffineTransformConcat(scale, translate)
        })
        */
        
        //~~~~TRANSFORM USING SPRING~~~~~ 
        //Same as above, but with Spring. 
        //1. Set initial settings for popoverView.
        let scale = CGAffineTransformMakeScale(0.3, 0.3)
        let translate = CGAffineTransformMakeTranslation(200, -200)
        self.popoverView.transform = CGAffineTransformConcat(scale, translate)
        self.popoverView.alpha = 0
        spring(0.5, animations: {
            //2. Animate it on press.
                let scale = CGAffineTransformMakeScale(1, 1)
                let translate = CGAffineTransformMakeTranslation(0, 0)
                self.popoverView.transform = CGAffineTransformConcat(scale, translate)
                self.popoverView.alpha = 1
            })
            //3. Make mask button visible. 
            showMask()
    }
    func hidePopover() {
        spring(0.5, animations: {
            self.popoverView.hidden = true
        })
    }
    
    func showMask() {
        self.maskButton.hidden = false
        self.maskButton.alpha = 0
        spring(0.5, animations: {
            self.maskButton.alpha = 1
        })
    }
    
    func hideMask() {
        spring(0.5, animations: {
            self.maskButton.alpha = 0
        })
        self.maskButton.hidden = true

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
        
        /*
        //VERSION 1 - STANDARD WAY
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
        */
        
        //VERSION 2 - USING MENG TO'S SPRING
        //Since we need to transition into the detail screen, we need a completion (as per above). 
        
        springWithCompletion(0.5, animations: {
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
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var shareLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var twitterLabel: UILabel!
    @IBOutlet weak var facebookLabel: UILabel!
    
    //grouping together the share labels into one view
    @IBOutlet weak var shareLabelsView: UIView!
    @IBOutlet weak var facebookButton: UIButton!
    @IBAction func shareButtonDidPress(sender: AnyObject) {
        print("Share button pressed.")
        shareView.hidden = false
        
        //Makes backgroundMaskView blur the background.
        insertBlurView(backgroundMaskView, style: UIBlurEffectStyle.Dark)
        
        //Invisible initially.
        self.shareView.alpha = 0
        self.shareLabelsView.alpha = 0
        
        //Set initial translations for shareView, including email and twitter and facebook buttons.
        self.shareView.transform = CGAffineTransformMakeTranslation(0, 200)
        self.emailButton.transform = CGAffineTransformMakeTranslation(0, 200)
        self.twitterButton.transform = CGAffineTransformMakeTranslation(0, 200)
        self.facebookButton.transform = CGAffineTransformMakeTranslation(0, 200)

        
        /* VERSION 1 - TRANSLATING ONLY, WITHOUT SPRINGINESS
        UIView.animateWithDuration(0.5, animations: {
            self.shareView.alpha = 1
            //Animate it so that it slides upwards (translate). This is where it ends up.
            self.shareView.transform = CGAffineTransformMakeTranslation(0, 0)
            
        })
        */
        
        
        /* VERSION 2 - ADDING SPRINGINESS TO THE NEWLY APPEARED SHAREVIEW
        //NB: I would have liked to set options to nil, but it came up with an error, so I just replaced it with something else: UIViewAnimationOptions.AllowAnimatedContent.
        
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.AllowAnimatedContent, animations: {
                self.shareView.alpha = 1
                //Animate it so that it slides upwards (translate). This is where it ends up.
                self.shareView.transform = CGAffineTransformMakeTranslation(0, 0)
            }, completion: nil)
        */
        
        // VERSION 3 - THE EXACT SAME AS ABOVE, BUT USING MENG TO'S SPRING
        //NB: remember that you have to import Spring into the application. For some weird reason, you have to put the SpringAnimation class containing the public function into the top level of the folder hierarchy; keeping it inside the Spring folder leaves it inaccessible for some reason.
        //NB: I've had to modify the function to add the .AllowAnimatedContent bit. See Version 2. 
        
        //Makes maskButton appear. The reason for doing this is so that you can have a space to "click out of". See maskButtonDidPress.
        maskButton.hidden = false

        spring(0.5, animations: {
            self.shareView.alpha = 1
            //Animate it so that it slides upwards (translate). This is where it ends up.
            self.shareView.transform = CGAffineTransformMakeTranslation(0, 0)
            
            //Shrinks the dialog view.
            self.dialogView.transform = CGAffineTransformMakeScale(0.8, 0.8)
            
        })
        
        //SpringWithDelay waits a bit. 
        //This code springs up the email, twitter, and Facebook buttons. It will bring them up one by one.
        springWithDelay(0.5, delay: 0.05, animations: {
            self.emailButton.transform = CGAffineTransformMakeTranslation(0, 0)
        })
        springWithDelay(0.5, delay: 0.10, animations: {
            self.twitterButton.transform = CGAffineTransformMakeTranslation(0, 0)
        })
        springWithDelay(0.5, delay: 0.15, animations: {
            self.facebookButton.transform = CGAffineTransformMakeTranslation(0, 0)
        })
        
        //Finally, we want the labels to also appear with a fade-in animation.
        UIView.animateWithDuration(0.5, delay: 0.15, options: UIViewAnimationOptions.AllowAnimatedContent, animations: {
            self.shareLabelsView.alpha = 1
            }, completion: nil)

    }
    
    func hideShareView() {
        spring(0.5, animations: {
            self.shareView.transform = CGAffineTransformMakeTranslation(0, 0)
            self.dialogView.transform = CGAffineTransformMakeScale(1, 1)
            self.shareView.hidden = true
        })
    }
    
    
    
    
    @IBOutlet weak var popoverView: UIView!
    @IBOutlet weak var shareView: UIView!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //~~PLAYING WITH TRANSFORMS~~
        
        /*
        //VERSION 1
        //1. dialogView starts with a scale of 0.5. From 0.5, it is animated to its full size (1) in 0.4 seconds.
        dialogView.transform = CGAffineTransformMakeScale(0.5, 0.5)
        UIView.animateWithDuration(0.4, animations: {
            self.dialogView.transform = CGAffineTransformMakeScale(1, 1)
        })
        */
        
        //VERSION 2
        //2. This time, we'll make some variables so that we can apply multiple transforms at once. 
        let scale = CGAffineTransformMakeScale(0.5, 0.5)
        let translate = CGAffineTransformMakeTranslation(0, -200)
        self.dialogView.transform = CGAffineTransformConcat(scale, translate)
        
        //3. Then, set the position that it will animate to.
        UIView.animateWithDuration(0.5, animations: {
            let scale = CGAffineTransformMakeScale(1, 1)
            let translate = CGAffineTransformMakeTranslation(0, 0)
            self.dialogView.transform = CGAffineTransformConcat(scale, translate)
        })
        
        //We'll do the same for the popover view in userButtonDidPress.
        
  
        
        
        
    }
    
    @IBOutlet weak var maskButton: UIButton!
    @IBAction func maskButtonDidPress(sender: AnyObject) {
        spring(0.5, animations: {
            self.maskButton.alpha = 0
        })
        hideShareView()
        hidePopover()
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
