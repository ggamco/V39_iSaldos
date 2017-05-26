//
//  SAOfertasTVC.swift
//  iSaldos
//
//  Created by cice on 19/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Kingfisher
import PKHUD
import PromiseKit

class SAOfertasTVC: UITableViewController {

    //MARK: - Variables Locales
    var arrayOfertas = [SAPromocionesModel]()
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var menuBTN: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //LLAMADA
        llamadaOfertas()
        
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayOfertas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = tableView.dequeueReusableCell(withIdentifier: "ISOfertaCustomCell", for: indexPath) as! ISOfertaCustomCell
        
        let model = arrayOfertas[indexPath.row]
        customCell.myNombreOferta.text = model.nombre
        customCell.myFechaOferta.text = model.fechaFin
        customCell.myInformacionOferta.text = model.masInformacion
        customCell.myImporteOferta.text = model.importe
        customCell.myImagenOferta.kf.setImage(with: ImageResource(downloadURL: URL(string: getImagePath(CONSTANTES.LLAMADAS.BASE_URL_FOTO, id: model.id!, nombre: model.imagen!))!),
                                              placeholder: #imageLiteral(resourceName: "placeholder"),
                                              options: nil,
                                              progressBlock: nil,
                                              completionHandler: nil)
        
        return customCell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 310
    }
    
    //MARK: - Utils
    func llamadaOfertas() {
        let datosOfertas = SAParserPromociones()
        let idLocalidad = "11"
        let tipoOfertas = CONSTANTES.LLAMADAS.OFERTAS
        let tipoParametro = CONSTANTES.LLAMADAS.PROMOCIONES_SERVICE
        
        HUD.show(.progress)
        firstly{
            return when(resolved: datosOfertas.getDatosPromociones(idLocalidad, idTipo: tipoOfertas, idParametro: tipoParametro))
            }.then { _ in
                self.arrayOfertas = datosOfertas.getParserPromociones()
            }.then { _ in
                self.tableView.reloadData()
            }.then { _ in
                HUD.hide(afterDelay: 0)
            }.catch { error in
                self.present(muestraAlertVC(titleData: "AQUI", messageData: "PROBLEMAS DE DESCARGA"), animated: true, completion: nil)
            }
    }
    
}
