//
//  SAParserNasa.swift
//  iSaldos
//
//  Created by cice on 2/6/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import SwiftyJSON
import PromiseKit
import Alamofire

class SAParserNasa: NSObject {

    var jsonDataNASA : JSON?
    
    func getDatosNasa() -> Promise<JSON> {
        
        let customRequest = URLRequest(url: URL(string: CONSTANTES.LLAMADAS.URL_NASA)!)
        
        return Alamofire.request(customRequest).responseJSON().then{(dataJSON) -> JSON in
            self.jsonDataNASA = JSON(dataJSON)
            //print(self.jsonDataPromociones)
            return self.jsonDataNASA!
        }
        
    }
    
    func getParserNasaNoticias() -> [SANasaModel] {
        
        var arrayNoticias = [SANasaModel]()
        
        for c_noticia in (jsonDataNASA?["news"])! {
            let nasaModel = SANasaModel(p_Id: dimeString(c_noticia.1, nombre: "Id"),
                                        p_fecha: dimeString(c_noticia.1, nombre: "fecha"),
                                        p_date: dimeString(c_noticia.1, nombre: "date"),
                                        p_explanation: dimeString(c_noticia.1, nombre: "explanation"),
                                        p_hdurl: dimeString(c_noticia.1, nombre: "hdurl"),
                                        p_title: dimeString(c_noticia.1, nombre: "title"),
                                        p_url: dimeString(c_noticia.1, nombre: "url"))
            
            
            arrayNoticias.append(nasaModel)
        }
        
        return arrayNoticias
    }
    
}
