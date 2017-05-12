//
//  SASplashViewController.swift
//  iSaldos
//
//  Created by cice on 12/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Parse

class SASplashViewController: UIViewController {

    //MARK: - Variables locales
    
    var viewAnimator: UIViewPropertyAnimator!
    var timerDesbloqueo = Timer()
    
    //MARK: - IBOutlets
    @IBOutlet weak var myImageSplash: UIImageView!
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewAnimator = UIViewPropertyAnimator(duration: 1.0, curve: .easeInOut, animations: { 
            self.myImageSplash.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            self.timerDesbloqueo = Timer.scheduledTimer(timeInterval: 1.5,
                                                        target: self,
                                                        selector: #selector(self.manejadorAutomatico),
                                                        userInfo: nil,
                                                        repeats: false)
        })
        
        viewAnimator.startAnimation()
        
    }
    
    //MARK: - UTILS
    func manejadorAutomatico() {
        let logoAnimation = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut) { 
            self.myImageSplash.transform = CGAffineTransform(scaleX: 25, y: 25)
        }
        logoAnimation.startAnimation()
        logoAnimation.addCompletion { _ in
            self.beginApp()
        }
    }
    
    func beginApp() {
        if(customPrefs.string(forKey: CONSTANTES.CUSTOM_USER_DEFAULTS.VISTA_GENERAL_INICIAL)) != nil {
            if PFUser.current() == nil{
                let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "SALoginViewController") as! SALoginViewController
                loginVC.modalTransitionStyle = .crossDissolve
                present(loginVC, animated: true, completion: nil)
            } else {
                let revealVC = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                revealVC.modalTransitionStyle = .crossDissolve
                present(revealVC, animated: true, completion: nil)
            }
        } else {
            customPrefs.setValue("OK", forKey: CONSTANTES.CUSTOM_USER_DEFAULTS.VISTA_GENERAL_INICIAL)
            let galeriaVC = self.storyboard?.instantiateViewController(withIdentifier: "SAGaleriaImagenesViewController") as! SAGaleriaImagenesViewController
            galeriaVC.modalTransitionStyle = .crossDissolve
            present(galeriaVC, animated: true, completion: nil)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
