//
//  SANasaDetalleTableViewController.swift
//  iSaldos
//
//  Created by cice on 2/6/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit

class SANasaDetalleTableViewController: UITableViewController {

    //variables Locales
    var noticia : SANasaModel?
    var detalleImagen : UIImage?
    
    //MARK: - IBOutlets
    @IBOutlet weak var myImagenDetalle: UIImageView!
    @IBOutlet weak var myTitulo: UILabel!
    @IBOutlet weak var myFecha: UILabel!
    @IBOutlet weak var myTituloExplicacion: UILabel!
    @IBOutlet weak var myExplicacion: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        
        myImagenDetalle.image = detalleImagen
        myTitulo.text = noticia?.title
        //myFecha.text = formatFecha(noticia?.fecha)
        myTituloExplicacion.text = noticia?.title
        myExplicacion.text = noticia?.explanation
        
        
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 && indexPath.row == 1 {
            return UITableViewAutomaticDimension
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    

}
