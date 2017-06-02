//
//  ISCanalSocialViewController.swift
//  iSaldos
//
//  Created by cice on 2/6/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Parse

class ISCanalSocialViewController: UIViewController {

    //MARK: - Variables Locales
    var userPost = [SAUserPostModel]()
    var refreshList : UIRefreshControl?
    var nombreUser = ""
    var apellidoUser = ""
    var imagenUser: UIImage?
    var username = ""
    
    //MARK: - IBOutlets
    @IBOutlet weak var myTableView: UITableView!
    
    
    //MARK: - LIFE VC
    override func viewDidLoad() {
        super.viewDidLoad()

        refreshList = UIRefreshControl()
        refreshList?.addTarget(self, action: #selector(llamadaPosters), for: .valueChanged)
        myTableView.addSubview(refreshList!)
        
        myTableView.delegate = self
        myTableView.dataSource = self
        
        myTableView.register(UINib(nibName: "SRMiPerfilCustomCell", bundle: nil), forCellReuseIdentifier: "SRMiPerfilCustomCell")
        myTableView.register(UINib(nibName: "ISPostCustomCell", bundle: nil), forCellReuseIdentifier: "ISPostCustomCell")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        informacionUsuario()
        llamadaPosters()
        
        myTableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        llamadaPosters()
        myTableView.reloadData()
    }
    
    
    //MARK: - Utils
    func informacionUsuario() {
        
        //1. consulta
        let queryUser = PFUser.query()
        queryUser?.whereKey("username", equalTo: (PFUser.current()?.username)!)
        queryUser?.findObjectsInBackground(block: { (objetoUno, errorUno) in
            
            if errorUno == nil {
                
                if let objetoUnoDes = objetoUno?[0]{
                    self.nombreUser = (objetoUnoDes["nombre"] as? String)!
                    self.apellidoUser = (objetoUnoDes["apellido"] as? String)!
                    self.username = (PFUser.current()?.username)!
                    //2. solicitud de imagen
                    let imagenPerfil = PFQuery(className: "ImageProfile")
                    imagenPerfil.whereKey("username", equalTo: (PFUser.current()?.username)!)
                    imagenPerfil.findObjectsInBackground(block: { (objetoDos, errorDos) in
                        if errorDos == nil {
                            if let objetoDosDes = objetoDos?[0] {
                                let imageUserData = objetoDosDes["imageProfile"] as! PFFile
                                imageUserData.getDataInBackground(block: { (imageData, errorTres) in
                                    if errorTres == nil {
                                        if let imageDataDes = imageData {
                                            self.imagenUser = UIImage(data: imageDataDes)
                                            self.myTableView.reloadData()
                                        }
                                    }
                                })
                            }
                        }
                    })
                    
                    
                }
            }
            
        })
        
        
        
    }
    
    func llamadaPosters() {
        
    }
    

}//FIN DE LA CLASE

extension ISCanalSocialViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return userPost.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
        
            let perfilCell = tableView.dequeueReusableCell(withIdentifier: "SRMiPerfilCustomCell", for: indexPath) as! SRMiPerfilCustomCell
            
            perfilCell.myFotoPerfilUsuario.image = imagenUser
            perfilCell.myNombrePerfilUsuario.text = nombreUser + " " + apellidoUser
            perfilCell.myUsernameSportReviewLBL.text = "@\(username)"
            
            return perfilCell
            
        } else {
            let posterCell = tableView.dequeueReusableCell(withIdentifier: "ISPostCustomCell", for: indexPath) as! ISPostCustomCell
            
            return posterCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 305
        } else {
            return UITableViewAutomaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}














