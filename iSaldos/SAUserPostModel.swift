//
//  SAUserPostModel.swift
//  iSaldos
//
//  Created by cice on 2/6/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Parse

class SAUserPostModel: NSObject {

    var nombre : String?
    var apellido : String?
    var username : String?
    var imageProfile : PFFile?
    var imagePoster : PFFile?
    var fechaCreacion : String?
    var descripcionImage : String?
    
    init(p_nombre : String, p_apellido : String, p_username : String, p_imageProfile : PFFile, p_imagePoster : PFFile, p_fechaCreacion : String, p_descripcionImagen : String) {
        
        self.nombre = p_nombre
        self.apellido = p_apellido
        self.username = p_username
        self.imageProfile = p_imageProfile
        self.imagePoster = p_imagePoster
        self.fechaCreacion = p_fechaCreacion
        self.descripcionImage = p_descripcionImagen
        
    }
}
