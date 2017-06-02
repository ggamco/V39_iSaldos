//
//  ISNuevoPostTableViewController.swift
//  iSaldos
//
//  Created by cice on 2/6/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Parse

class ISNuevoPostTableViewController: UITableViewController {

    //MARK: - Variables Locales
    var fotoSeleccionada = false
    var fechaHumana = Date()
    
    var nombreUser = ""
    var apellidoUser = ""
    var username = ""
    var imagenUser : UIImage?
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var myImagenPerfil: UIImageView!
    @IBOutlet weak var myUsername: UILabel!
    @IBOutlet weak var myNombreCompleto: UILabel!
    @IBOutlet weak var myFechaPerfil: UILabel!
    @IBOutlet weak var myDescripcionPoster: UITextView!
    @IBOutlet weak var myImagenPoster: UIImageView!
    
    
    //MARK: - IBActions
    
    @IBAction func ocultarVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        myDescripcionPoster.delegate = self
        
        //BLOQUE DE TOOLBAR
        let barraFlexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let colorWB = CONSTANTES.COLORES.BLANCO_TEXTO_NAV
        let colorTB = CONSTANTES.COLORES.GRIS_NAV_TAB
        
        let camara = UIBarButtonItem(image: UIImage(named: "camara"),
                                     style: .done,
                                     target: self,
                                     action: #selector(pickerPhoto))
        
        let guardar = UIBarButtonItem(title: "Guardar",
                                      style: .plain,
                                      target: self,
                                      action: #selector(salvarDatos))
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
        toolBar.barStyle = .blackOpaque
        toolBar.tintColor = colorWB
        toolBar.barTintColor = colorTB
        
        toolBar.items = [camara, barraFlexible, guardar]
        
        myDescripcionPoster.inputAccessoryView = toolBar
        
        let customDateFormater = DateFormatter()
        customDateFormater.dateStyle = .medium
        myFechaPerfil.text = "fecha" + " " + customDateFormater.string(from: fechaHumana)
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.bajarTeclado))
        tableView.addGestureRecognizer(tapGR)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myDescripcionPoster.becomeFirstResponder()
        muestraInformacionUsuario()
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Utils
    
    func bajarTeclado(){
        myDescripcionPoster.resignFirstResponder()
    }
    
    func salvarDatos() {
        
    }
    
    func muestraInformacionUsuario() {
        //1. consulta
        let queryUser = PFUser.query()
        queryUser?.whereKey("username", equalTo: (PFUser.current()?.username)!)
        queryUser?.findObjectsInBackground(block: { (objetoUno, errorUno) in
            
            if errorUno == nil {
                
                if let objetoUnoDes = objetoUno?[0]{
                    self.nombreUser = (objetoUnoDes["nombre"] as? String)!
                    self.apellidoUser = (objetoUnoDes["apellido"] as? String)!
                    self.myUsername.text = (PFUser.current()?.username)!
                    self.myNombreCompleto.text = self.nombreUser + " " + self.apellidoUser
                    //2. solicitud de imagen
                    let imagenPerfil = PFQuery(className: "ImageProfile")
                    imagenPerfil.whereKey("username", equalTo: (PFUser.current()?.username)!)
                    imagenPerfil.findObjectsInBackground(block: { (objetoDos, errorDos) in
                        if errorDos == nil {
                            if let objetoDosDes = objetoDos?[0] {
                                let imageUserData = objetoDosDes["imageProfile"] as! PFFile
                                imageUserData.getDataInBackground(block: { (imageData, errorTres) in
                                    if errorTres == nil {
                                        if let imageDataDes = imageData {
                                            self.myImagenPerfil.image = UIImage(data: imageDataDes)
                                        }
                                    }
                                })
                            }
                        }
                    })
                    
                    
                }
            }
            
        })
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return UITableViewAutomaticDimension
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }

}

extension ISNuevoPostTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func pickerPhoto(){
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            muestraMenu()
        } else {
            muestraLibreriaFotos()
        }
        
    }
    
    func muestraMenu(){
        let alertVC = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        let tomaFoto = UIAlertAction(title: "Toma foto", style: .default) { _ in
            
            self.muestraCamaraDispositivo()
            
        }
        let seleccionaFoto = UIAlertAction(title: "Selecciona desde Fotos", style: .default) { _ in
            
            self.muestraLibreriaFotos()
            
        }
        
        alertVC.addAction(cancelAction)
        alertVC.addAction(tomaFoto)
        alertVC.addAction(seleccionaFoto)
        present(alertVC, animated: true, completion: nil)
    }
    
    func muestraLibreriaFotos(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func muestraCamaraDispositivo(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let imageData = info[UIImagePickerControllerOriginalImage] as? UIImage{
            myImagenPoster.image = imageData
            if myImagenPoster != nil {
                fotoSeleccionada = true
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
}

extension ISNuevoPostTableViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
            self.navigationController?.setToolbarHidden(true, animated: true)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "¿Qué está pasando?"
            textView.textColor = UIColor.lightGray
            self.navigationController?.setToolbarHidden(false, animated: true)
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let currentOffset = tableView.contentOffset
        UIView.setAnimationsEnabled(false)
        tableView.beginUpdates()
        tableView.endUpdates()
        UIView.setAnimationsEnabled(true)
        tableView.setContentOffset(currentOffset, animated: false)
    }
    
    
    
    
}



