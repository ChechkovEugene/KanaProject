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
        
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {
            self.hiraganaBtn.titleLabel!.font = UIFont(name: "Zapfino", size: 60.0)
            self.katakanaBtn.titleLabel!.font = UIFont(name: "Zapfino", size: 60.0)
        } else {
            self.hiraganaBtn.titleLabel!.font = UIFont(name: "Zapfino", size: 20.0)
            self.katakanaBtn.titleLabel!.font = UIFont(name: "Zapfino", size: 20.0)
        }
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? KanaGuessController {
            viewController.kanaType = kanaType
        }
    }
    
    @IBAction func selectHiragana(_ sender: AnyObject) {
        kanaType = .hiragana
        self.performSegue(withIdentifier: "showGuessKontroller", sender: sender)
    }
    @IBAction func selectKatakana(_ sender: AnyObject) {
        kanaType = .katakana
        self.performSegue(withIdentifier: "showGuessKontroller", sender: sender)
    }   
}
