//
//  SANasaModel.swift
//  iSaldos
//
//  Created by cice on 2/6/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit

class SANasaModel: NSObject {

    //Modelo de datos. 
    //Declaramos las variables del JSON.
    var Id : String?
    var fecha : String?
    var date : String?
    var explanation : String?
    var hdurl : String?
    var title : String?
    var url : String?
    
    //Inicializador
    init(p_Id: String, p_fecha: String, p_date: String, p_explanation: String, p_hdurl: String, p_title: String, p_url: String){
        
        self.Id = p_Id
        self.fecha = p_fecha
        self.date = p_date
        self.explanation = p_explanation
        self.hdurl = p_hdurl
        self.title = p_title
        self.url = p_url
        
    }
    
    
}
