//
//  SAPromocionesModel.swift
//  iSaldos
//
//  Created by cice on 19/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import Foundation

class SAPromocionesModel: NSObject {
    
    //url del json: http://app.clubsinergias.es/api_comercios.php?idlocalidad=11&tipo=oferta&p=promociones
    
    var id : String?
    var tipoPromocion : String?
    var nombre : String?
    var importe: String?
    var imagen : String?
    var fechaFin : String?
    var masInformacion : String?
    var asociado : SAAsociadoModel
    
    init(p_id : String, p_tipoPromocion : String, p_nombre : String, p_importe : String, p_imagen : String, p_fechaFin : String, p_masInformacion : String, p_asociado : SAAsociadoModel) {
        self.id = p_id
        self.tipoPromocion = p_tipoPromocion
        self.nombre = p_nombre
        self.importe = p_importe
        self.imagen = p_imagen
        self.fechaFin = p_fechaFin
        self.masInformacion = p_masInformacion
        self.asociado = p_asociado
    }

}
