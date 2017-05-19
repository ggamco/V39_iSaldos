//
//  SALoginViewController.swift
//  iSaldos
//
//  Created by cice on 12/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Parse
import AVFoundation

class SALoginViewController: UIViewController {

    //MARK: - Variables locales
    var player : AVPlayer!
    
    //MARK: - IBOutlets
    @IBOutlet weak var myUsername: UITextField!
    @IBOutlet weak var myPassword: UITextField!
    @IBOutlet weak var myAccederBTN: UIButton!
    @IBOutlet weak var myRegistrarBTN: UIButton!
    
    //MARK: - IBActions
    @IBAction func accederApp(_ sender: UIButton) {
        
        let sign = APISignIn(p_username: myUsername.text!, p_password: myPassword.text!)
        
        do {
            try sign.signUser()
            self.performSegue(withIdentifier: "jumpFromLogin", sender: self)
        } catch let error{
            present(muestraAlertVC(titleData: "Lo sentimos", messageData: "\(error.localizedDescription)"),
                    animated: true,
                    completion: nil)
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showVideoInVC()
        
        myAccederBTN.layer.cornerRadius = 5
        myRegistrarBTN.layer.cornerRadius = 5
        
        // Do any additional setup after loading the view.
    }

    func showVideoInVC() {
        let path = Bundle.main.path(forResource: "Nike_iOS", ofType: "mp4")
        
        player = AVPlayer(url: URL(fileURLWithPath: path!))
        player?.actionAtItemEnd = .none
        
        let playerLayer = AVPlayerLayer.init(player: player)
        playerLayer.frame = self.view.frame
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        self.view.layer.insertSublayer(playerLayer, at: 0)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItem),
                                               name: .AVPlayerItemDidPlayToEndTime,
                                               object: player.currentItem)
        
        player.seek(to: kCMTimeZero)
        player.play()
    }
    
    func playerItem() {
        player.seek(to: kCMTimeZero)
    }

}
