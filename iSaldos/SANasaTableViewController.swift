//
//  SANasaTableViewController.swift
//  iSaldos
//
//  Created by cice on 2/6/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Kingfisher
import PKHUD
import PromiseKit

class SANasaTableViewController: UITableViewController {

    //MARK: - Variables Locales
    var arrayNoticias = [SANasaModel]()
    
    //MARK: - IBOutlets
    @IBOutlet weak var menuBTN: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //LLAMADA
        llamadaNoticias()
        
        //TODO: - Mostramos el menu lateral
        if revealViewController() != nil {
            menuBTN.target = revealViewController()
            menuBTN.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rightViewRevealWidth = 150
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        //REGISTRO DE LA CELDA
        tableView.register(UINib(nibName: "ISOfertaCustomCell", bundle: nil), forCellReuseIdentifier: "ISOfertaCustomCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func llamadaNoticias() {
        let datosOfertas = SAParserNasa()
        
        HUD.show(.progress)
        firstly{
            return when(resolved: datosOfertas.getDatosNasa())
            }.then { _ in
                self.arrayNoticias = datosOfertas.getParserNasaNoticias()
            }.then { _ in
                self.tableView.reloadData()
            }.then { _ in
                HUD.hide(afterDelay: 0)
            }.catch { error in
                self.present(muestraAlertVC(titleData: "AQUI", messageData: "PROBLEMAS DE DESCARGA"), animated: true, completion: nil)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayNoticias.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ISOfertaCustomCell", for: indexPath) as! ISOfertaCustomCell

        let noticia = arrayNoticias[indexPath.row]
        
        cell.myNombreOferta.text = noticia.title
        cell.myImagenOferta.kf.setImage(with: ImageResource(downloadURL: URL(string: noticia.url!)!),
                                        placeholder: #imageLiteral(resourceName: "placeholder"),
                                        options: nil,
                                        progressBlock: nil,
                                        completionHandler: nil)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 310
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showNasaSegue", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNasaSegue" {
            let detalleVC = segue.destination as! SANasaDetalleTableViewController
            let selectIndex = tableView.indexPathForSelectedRow?.row
            let objIndex = arrayNoticias[selectIndex!]
            detalleVC.noticia = objIndex
            
            do {
                let imageData = UIImage(data: try Data(contentsOf: URL(string: objIndex.url!)!))
                detalleVC.detalleImagen = imageData
            } catch {
                
            }
        }
    }
    
}
