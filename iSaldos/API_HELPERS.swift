//
//  API_HELPERS.swift
//  iSaldos
//
//  Created by cice on 12/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import Foundation
import SwiftyJSON
import MessageUI

let customPrefs = UserDefaults.standard

//funcion alertVC generico
func muestraAlertVC(titleData: String, messageData: String) -> UIAlertController {
    
    let alertVC = UIAlertController(title: titleData,
                                    message: messageData,
                                    preferredStyle: .alert)
    
    alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    return alertVC
    
}

//funcion de configuracion de MFMailComposeVC
func configuredMailCompose() -> MFMailComposeViewController {
    
    let mailCompose = MFMailComposeViewController()
    mailCompose.setToRecipients([""])
    mailCompose.setSubject("Ayuda para saber más de la app")
    mailCompose.setMessageBody("Escriba un mensaje al equipo de soporte de la app", isHTML: false)
    return mailCompose
    
}

//funcion de mil a string vacio
func dimeString(_ json: JSON, nombre: String) -> String {
    if let stringResult = json[nombre].string{
        return stringResult
    } else {
        return ""
    }
}
