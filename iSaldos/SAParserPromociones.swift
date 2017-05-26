//
//  SAParserPromociones.swift
//  iSaldos
//
//  Created by cice on 26/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import SwiftyJSON
import PromiseKit
import Alamofire

class SAParserPromociones: NSObject {

    var jsonDataPromociones : JSON?
    
    func getDatosPromociones(_ idLocalidad: String, idTipo: String, idParametro: String) -> Promise<JSON> {
        
        let customRequest = URLRequest(url: URL(string: CONSTANTES.LLAMADAS.BASE_URL + CONSTANTES.LLAMADAS.BASE_URL_LOCALIDAD + idLocalidad + "&tipo=" + idTipo + "&p=" + idParametro)!)
        
        return Alamofire.request(customRequest).responseJSON().then{(dataJSON) -> JSON in
            self.jsonDataPromociones = JSON(dataJSON)
            //print(self.jsonDataPromociones)
            return self.jsonDataPromociones!
        }
        
    }
    
    func getParserPromociones() -> [SAPromocionesModel] {
        
        var arrayPromociones = [SAPromocionesModel]()
        
        for c_promocion in (jsonDataPromociones?["promociones"])! {
            let asociadoModel = SAAsociadoModel(p_id: dimeString(c_promocion.1["asociado"], nombre: "id"),
                                                p_nombre: dimeString(c_promocion.1["asociado"], nombre: "nombre"),
                                                p_descripcion: dimeString(c_promocion.1["asociado"], nombre: "descripcion"),
                                                p_condicionesEspeciales: dimeString(c_promocion.1["asociado"], nombre: "condicionesEspeciales"),
                                                p_direccion: dimeString(c_promocion.1["asociado"], nombre: "direccion"),
                                                p_idActividad: dimeString(c_promocion.1["asociado"], nombre: "idActividad"),
                                                p_idLocalidad: dimeString(c_promocion.1["asociado"], nombre: "idLocalidad"),
                                                p_imagen: dimeString(c_promocion.1["asociado"], nombre: "imagen"),
                                                p_telefenoFijo: dimeString(c_promocion.1["asociado"], nombre: "telefonoFijo"),
                                                p_telefenoMovil: dimeString(c_promocion.1["asociado"], nombre: "telefonoMovil"),
                                                p_mail: dimeString(c_promocion.1["asociado"], nombre: "mail"),
                                                p_web: dimeString(c_promocion.1["asociado"], nombre: "web"))
            
            let promocionModel = SAPromocionesModel(p_id: dimeString(c_promocion.1, nombre: "id"),
                                                    p_tipoPromocion: dimeString(c_promocion.1, nombre: "tipoPromocion"),
                                                    p_nombre: dimeString(c_promocion.1, nombre: "nombre"),
                                                    p_importe: dimeString(c_promocion.1, nombre: "importe"),
                                                    p_imagen: dimeString(c_promocion.1, nombre: "imagen"),
                                                    p_fechaFin: dimeString(c_promocion.1, nombre: "fechaFin"),
                                                    p_masInformacion: dimeString(c_promocion.1, nombre: "masInformacion"),
                                                    p_asociado: asociadoModel)
            
            arrayPromociones.append(promocionModel)
        }
        
        return arrayPromociones
    }
    
}
