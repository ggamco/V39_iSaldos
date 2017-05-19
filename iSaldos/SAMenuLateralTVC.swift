//
//  SAMenuLateralTVC.swift
//  iSaldos
//
//  Created by cice on 19/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Parse
import MessageUI

class SAMenuLateralTVC: UITableViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var myImagenPerfil: UIImageView!
    @IBOutlet weak var myNombrePerfil: UILabel!
    @IBOutlet weak var myApellidoPerfil: UILabel!
    @IBOutlet weak var myEmailPerfil: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //llamada a parse
        dameinformacionParse()
        
        myImagenPerfil.layer.cornerRadius = myImagenPerfil.frame.width / 2
        myImagenPerfil.layer.borderColor = CONSTANTES.COLORES.GRIS_NAV_TAB.cgColor
        myImagenPerfil.layer.borderWidth = 1
        myImagenPerfil.clipsToBounds = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - Utils
    func dameinformacionParse() {
        
        //1º CONSULTA
        let queryData = PFUser.query()
        queryData?.whereKey("username", equalTo: (PFUser.current()?.username)!)
        queryData?.findObjectsInBackground(block: { (objBusquedaUno, errorUno) in
            
            if errorUno == nil {
                
                if let objBusquedaUnoDes = objBusquedaUno?.first{
                    self.myNombrePerfil.text = objBusquedaUnoDes["nombre"] as? String
                    self.myApellidoPerfil.text = objBusquedaUnoDes["apellido"] as? String
                    self.myEmailPerfil.text = objBusquedaUnoDes["email"] as? String
                    
                    //2º CONSULTA
                    let queryFoto = PFQuery(className: "ImageProfile")
                    queryFoto.whereKey("username", equalTo: (PFUser.current()?.username)!)
                    queryFoto.findObjectsInBackground(block: { (objBusquedaDos, errorDos) in
                        if errorDos == nil {
                            if let objBusquedaDosDes = objBusquedaDos?.first {
                                
                                //3º CONSULTA
                                let imageDataFile = objBusquedaDosDes["imageProfile"] as! PFFile
                                
                                imageDataFile.getDataInBackground(block: { (imageDataTres, errorTres) in
                                    if let imageDataTresDes = imageDataTres{
                                        let imageDataFinal = UIImage(data: imageDataTresDes)
                                        self.myImagenPerfil.image = imageDataFinal
                                    }
                                })
                                
                            }
                        }
                    })
                    
                    
                    
                }
            }
        })
        
    }

}
