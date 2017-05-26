//
//  SAAsociadoModel.swift
//  iSaldos
//
//  Created by cice on 19/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit

class SAAsociadoModel: NSObject {

    var id : String?
    var nombre : String?
    var descripcion : String?
    var condicionesEspeciales : String?
    var direccion : String?
    var idActividad : String?
    var idLocalidad : String?
    var imagen : String?
    var telefonoFijo : String?
    var telefonoMovil : String?
    var mail : String?
    var web : String?
    
    init (p_id: String, p_nombre: String, p_descripcion: String, p_condicionesEspeciales: String, p_direccion: String, p_idActividad: String, p_idLocalidad: String, p_imagen: String, p_telefenoFijo: String, p_telefenoMovil: String, p_mail: String, p_web: String) {
        self.id = p_id
        self.nombre = p_nombre
        self.descripcion = p_descripcion
        self.condicionesEspeciales = p_condicionesEspeciales
        self.direccion = p_direccion
        self.idActividad = p_idActividad
        self.idLocalidad = p_idLocalidad
        self.imagen = p_imagen
        self.telefonoFijo = p_telefenoFijo
        self.telefonoMovil = p_telefenoMovil
        self.mail = p_mail
        self.web = p_web
    }

}
