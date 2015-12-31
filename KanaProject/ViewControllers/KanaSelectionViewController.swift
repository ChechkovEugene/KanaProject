//
//  KanaSelectionViewController.swift
//  KanaProject
//
//  Created by Eugene Chechkov on 2/27/15.
//  Copyright (c) 2015 Eugene Chechkov. All rights reserved.
//

import UIKit

class KanaSelectionViewController: UIViewController {
        
    @IBOutlet weak var hiraganaBtn: UIButton!
    @IBOutlet weak var katakanaBtn: UIButton!
    
    var kanaType: KanaType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad {
            self.hiraganaBtn.titleLabel!.font = UIFont(name: "Zapfino", size: 60.0)
            self.katakanaBtn.titleLabel!.font = UIFont(name: "Zapfino", size: 60.0)
        } else {
            self.hiraganaBtn.titleLabel!.font = UIFont(name: "Zapfino", size: 20.0)
            self.katakanaBtn.titleLabel!.font = UIFont(name: "Zapfino", size: 20.0)
        }
        
        self.navigationController?.navigationBar.hidden = true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.hidden = true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let viewController = segue.destinationViewController as? KanaGuessController {
            viewController.kanaType = kanaType
        }
    }
    
    @IBAction func selectHiragana(sender: AnyObject) {
        kanaType = .Hiragana
        self.performSegueWithIdentifier("showGuessKontroller", sender: sender)
    }
    @IBAction func selectKatakana(sender: AnyObject) {
        kanaType = .Katakana
        self.performSegueWithIdentifier("showGuessKontroller", sender: sender)
    }   
}
