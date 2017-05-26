//
//  SAOfertaDetalleTVC.swift
//  iSaldos
//
//  Created by cice on 19/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import MapKit

class SAOfertaDetalleTVC: UITableViewController {
    
    //MARK: - Variables Locales
    var oferta: SAPromocionesModel?
    var detalleImagen: UIImage?
    
    //MARK: - IBOutlets
    @IBOutlet weak var myImagen: UIImageView!
    @IBOutlet weak var myNombreOferta: UILabel!
    @IBOutlet weak var myFechaFin: UILabel!
    @IBOutlet weak var myMasInformacion: UILabel!
    @IBOutlet weak var myNombreAsociado: UILabel!
    @IBOutlet weak var myDescripcionAsociado: UILabel!
    @IBOutlet weak var myDireccionAsociado: UILabel!
    @IBOutlet weak var myTelefonoMovilAsociado: UILabel!
    @IBOutlet weak var myEmailAsociado: UILabel!
    @IBOutlet weak var myMapaAsociado: MKMapView!
    @IBOutlet weak var myTelefonoFijo: UIButton!
    @IBOutlet weak var myWebAsociado: UIButton!
    
    @IBAction func hacerLlamadaTelefonica(_ sender: UIButton) {
        let stringUno = sender.titleLabel?.text
        let phoneUrl = URL(string: String(format: "telprompt:%@", stringUno!))
        
        if let phoneUrlDes = phoneUrl {
            if UIApplication.shared.canOpenURL(phoneUrlDes) {
                UIApplication.shared.open(phoneUrlDes, options: [:], completionHandler: nil)
            }
        } else {
            present(muestraAlertVC(titleData: "AQUI", messageData: "NO SE PUEDE HACER LLAMADA DESDE EL SIMULADOR"), animated: true, completion: nil)
        }

    }
    @IBAction func muestraPaginaWebAsociado(_ sender: UIButton) {
        let stringWeb = sender.titleLabel?.text
        let webVC = self.storyboard?.instantiateViewController(withIdentifier: "SAWebViewController") as! SAWebViewController
        webVC.urlWeb = stringWeb
        present(webVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        
        myImagen.image = detalleImagen
        myNombreOferta.text = oferta?.nombre
        myFechaFin.text = oferta?.fechaFin
        myMasInformacion.text = oferta?.masInformacion
        myNombreAsociado.text = oferta?.asociado.nombre
        myDescripcionAsociado.text = oferta?.asociado.descripcion
        myDireccionAsociado.text = oferta?.asociado.direccion
        myTelefonoMovilAsociado.text = oferta?.asociado.telefonoMovil
        myEmailAsociado.text = oferta?.asociado.mail
        myTelefonoFijo.setTitle(oferta?.asociado.telefonoFijo, for: .normal)
        myWebAsociado.setTitle(oferta?.asociado.web, for: .normal)
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2DMake(40.352494, -3.809620), span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))
        myMapaAsociado.setRegion(region, animated: true)
        
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(40.352494, -3.809620)
        pointAnnotation.title = oferta?.asociado.direccion
        pointAnnotation.subtitle = oferta?.asociado.nombre
        myMapaAsociado.addAnnotation(pointAnnotation)
        
        

    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 && indexPath.row == 1 {
            return UITableViewAutomaticDimension
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }

    

}
