//
//  SAActionSheetPersonalizadoViewController.swift
//  iSaldos
//
//  Created by cice on 26/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit

class SAActionSheetPersonalizadoViewController: UIViewController {

    
    //MARK: - Variables Locales
    var arrayRedesSociales = ["Facebook", "Twitter"]
    var arrayImagenesRedesSociales = ["like", "nation"]
    
    //MARK: - IBOutlets
    @IBOutlet weak var myCustonView: UIView!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var myCancelarBTN: UIButton!
    
    //MARK: - IBActions
    @IBAction func ocultarCustomView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        self.view.isOpaque = false

        //Customizamos la vista
        myCustonView.layer.cornerRadius = 5
        myCustonView.layer.masksToBounds = false
        myCustonView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        myCustonView.layer.shadowColor = CONSTANTES.COLORES.GRIS_NAV_TAB.cgColor
        myCustonView.layer.shadowRadius = 20.0
        myCustonView.layer.shadowOpacity = 1.0
        
        //Redondeamos los botones
        myCancelarBTN.layer.cornerRadius = 5
        
        //delegados de la tableview
        myTableView.delegate = self
        myTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}//FIN DE LA CLASE

extension SAActionSheetPersonalizadoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayRedesSociales.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = myTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let modelText = arrayRedesSociales[indexPath.row]
        let modelImage = arrayImagenesRedesSociales[indexPath.row]
        
        customCell.textLabel?.text = modelText
        customCell.detailTextLabel?.text = "\(Date())"
        customCell.imageView?.image = UIImage(named: modelImage)
        
        return customCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
}
















