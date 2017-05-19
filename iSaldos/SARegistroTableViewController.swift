//
//  SARegistroTableViewController.swift
//  iSaldos
//
//  Created by cice on 12/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Parse

class SARegistroTableViewController: UITableViewController {

    //MARK: - Variables Locales
    var fotoSeleccionada = false
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var myImagenPerfil: UIImageView!
    @IBOutlet weak var myUsernameTF: UITextField!
    @IBOutlet weak var myPasswordTF: UITextField!
    @IBOutlet weak var myNombreTF: UITextField!
    @IBOutlet weak var myApellidoTF: UITextField!
    @IBOutlet weak var myEmailTF: UITextField!
    @IBOutlet weak var myTelefonoTF: UITextField!
    @IBOutlet weak var myActivity: UIActivityIndicatorView!
    
    //MARK: - IBActions
    @IBAction func hideVC(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registroEnParse(_ sender: UIButton) {
        
        var errorInicial = ""
        
        if verificaTF(myUsernameTF.text) || verificaTF(myPasswordTF.text) || verificaTF(myNombreTF.text) || verificaTF(myApellidoTF.text) || verificaTF(myEmailTF.text) || myImagenPerfil.image == nil {
            
            errorInicial = "Estimado usuario, rellene los campos solicitados."
            
        } else {
            let newUser = PFUser()
            newUser.username = myUsernameTF.text
            newUser.password = myPasswordTF.text
            newUser.email = myEmailTF.text
            newUser["nombre"] = myNombreTF.text
            newUser["apellido"] = myApellidoTF.text
            newUser["movil"] = myTelefonoTF.text
            
            myActivity.isHidden = false
            myActivity.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            
            newUser.signUpInBackground(block: { (exitoso, errorRegistro) in
                self.myActivity.stopAnimating()
                self.myActivity.isHidden = true
                UIApplication.shared.endIgnoringInteractionEvents()
                
                if errorRegistro != nil {
                    self.present(muestraAlertVC(titleData: "Atención", messageData: "\((errorRegistro?.localizedDescription)!)"), animated: true, completion: nil)
                } else {
                    self.signUpWithPhoto()
                    self.performSegue(withIdentifier: "jumpFromRegisterVC", sender: self)
                }
            })
            
            if errorInicial != "" {
                present(muestraAlertVC(titleData: "Atención", messageData: errorInicial), animated: true, completion: nil)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //mostrar u ocultar ActivityIndicator
        myActivity.isHidden = true
        
        //gesto sobre la imagen para que el usuario pueda interactuar
        myImagenPerfil.isUserInteractionEnabled = true
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(pickerPhoto))
        myImagenPerfil.addGestureRecognizer(tapGR)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Utils
    func verificaTF(_ string: String?) -> Bool {
        
        return string?.trimmingCharacters(in: .whitespaces) == ""
        
    }

    func signUpWithPhoto() {
        if !fotoSeleccionada {
            self.present(muestraAlertVC(titleData: "Atención", messageData: "Foto no seleccionada"), animated: true, completion: nil)
        } else {
            let imageProfile = PFObject(className: "ImageProfile")
            let imageDataProfile = UIImageJPEGRepresentation(myImagenPerfil.image!, 0.3)
            let imageProfileFile = PFFile(name: "userImageProfile.jpg", data: imageDataProfile!)
            
            imageProfile["imageProfile"] = imageProfileFile
            imageProfile["username"] = PFUser.current()?.username
            
            imageProfile.saveInBackground()
        }
    }
    

}

extension SARegistroTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
            myImagenPerfil.image = imageData
            fotoSeleccionada = true
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
}

