//
//  SACuponDetalleTableViewController.swift
//  iSaldos
//
//  Created by cice on 26/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit

class SACuponDetalleTableViewController: UITableViewController {

    //MARK: - Variables Locales
    var cupon: SAPromocionesModel?
    var detalleImagen: UIImage?
    
    //MARK: - Variables CB
    var qrData : String?
    var imageGroupTag = 3
    
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
    @IBOutlet weak var myTelefonoFijoAsociado: UILabel!
    @IBOutlet weak var myWebAsociado: UILabel!
    @IBOutlet weak var idActividadAsociado: UILabel!
    
    @IBAction func muestraCBAction(_ sender: Any) {
        
        let customBacground = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height * 2))
        customBacground.backgroundColor = CONSTANTES.COLORES.GRIS_NAV_TAB
        customBacground.alpha = 0.0
        customBacground.tag = imageGroupTag
        
        let customAnimationBack = UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) { 
            customBacground.alpha = 0.5
            self.view.addSubview(customBacground)
        }
        
        customAnimationBack.startAnimation()
        customAnimationBack.addCompletion { _ in
            self.muestraImagenCB()
        }
        
        //añadimos el gesto de reconocimiento para deselecionar
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(quitarCB))
        view.addGestureRecognizer(tapGR)
    }
    
    func quitarCB(){
        
        for c_subView in self.view.subviews {
            if c_subView.tag == self.imageGroupTag {
                c_subView.removeFromSuperview()
            }
        }
    }
    
    @IBAction func muestraActionSheetPersonalizado(_ sender: Any) {
        let sbData = UIStoryboard(name: "ActionSheetStoryboard", bundle: nil)
        let actionSheetVC = sbData.instantiateInitialViewController()
        actionSheetVC?.modalPresentationStyle = .overCurrentContext
        show(actionSheetVC as! UINavigationController, sender: self)
    }
    
    func muestraImagenCB() {
        
        if idActividadAsociado.text == qrData {
            let anchoImagen = self.view.frame.width / 1.5
            let altoImagen = self.view.frame.height / 3
            
            let imagenView = UIImageView(frame: CGRect(x: self.view.frame.width / 2 - anchoImagen / 2, y: self.view.frame.height / 2 - altoImagen / 2, width: anchoImagen, height: altoImagen))
            
            imagenView.contentMode = .scaleAspectFit
            imagenView.tag = imageGroupTag
            imagenView.image = fromString(qrData!)
            self.view.addSubview(imagenView)
            
        }else {
            //aqui error
        }
        
    }
    
    func fromString(_ string: String) -> UIImage {
        let data = string.data(using: String.Encoding.ascii)
        let filter = CIFilter(name: "CICode128BarcodeGenerator")
        filter!.setValue(data, forKey: "inputMessage")
        return UIImage(ciImage: filter!.outputImage!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        
        myImagen.image = detalleImagen
        myNombreOferta.text = cupon?.nombre
        myFechaFin.text = cupon?.fechaFin
        myMasInformacion.text = cupon?.masInformacion
        myNombreAsociado.text = cupon?.asociado.nombre
        myDescripcionAsociado.text = cupon?.asociado.descripcion
        myDireccionAsociado.text = cupon?.asociado.direccion
        myTelefonoMovilAsociado.text = cupon?.asociado.telefonoMovil
        myEmailAsociado.text = cupon?.asociado.mail
        myTelefonoFijoAsociado.text = cupon?.asociado.telefonoFijo
        myWebAsociado.text = cupon?.asociado.web
        idActividadAsociado.text = cupon?.asociado.idActividad
        
        qrData = cupon?.asociado.idActividad
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 && indexPath.row == 1 {
            return UITableViewAutomaticDimension
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
}
