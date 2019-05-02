//
//  ParcelDetailViewController.swift
//  Parcel Delivery
//
//  Created by alcoderithm on 6/4/19.
//  Copyright © 2019 alcoderithm. All rights reserved.
//

import UIKit

class ParcelDetailViewController: UITableViewController {
    
    var parcel: Parcel?
    var status = "Pick Up"
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var trackingNumber: UITextField!
    @IBOutlet weak var pickUp: UIButton!
    @IBOutlet weak var onRoute: UIButton!
    @IBOutlet weak var delivered: UIButton!
    @IBOutlet weak var dateTime: UILabel!
    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var notes: UITextField!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var deleteTableView: UITableViewCell!
    
    let lightBlue = UIColor(displayP3Red: 0.0, green: 0.588, blue: 1.0, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let parcel = parcel {
            navigationItem.title = "Parcels"
            name.text = parcel.receiverName
            address.text = parcel.receiverAddress
            trackingNumber.text = parcel.recieverTrackingNumber
            status = parcel.deliveryStatus
            date.date = parcel.deliveryDate
            notes.text = parcel.deliveryNotes
            deleteButton.isHidden = false
            deleteTableView.isHidden = false
        } else{
            date.date = Date().addingTimeInterval(24*60*60)
            deleteButton.isHidden = true
            deleteTableView.isHidden = true
        }
        
        if status == "Pick Up" {
            pickUp.isEnabled = false
            pickUp.setTitleColor(.white, for: .normal)
            pickUp.backgroundColor = lightBlue
            onRoute.isEnabled = true
            onRoute.setTitleColor(lightBlue, for: .normal)
            onRoute.backgroundColor = UIColor.white
            delivered.isEnabled = true
            delivered.setTitleColor(lightBlue, for: .normal)
            delivered.backgroundColor = UIColor.white
        } else if status == "On Route"{
            pickUp.isEnabled = true
            pickUp.setTitleColor(lightBlue, for: .normal)
            pickUp.backgroundColor = UIColor.white
            onRoute.isEnabled = false
            onRoute.setTitleColor(.white, for: .normal)
            onRoute.backgroundColor = lightBlue
            delivered.isEnabled = true
            delivered.setTitleColor(lightBlue, for: .normal)
            delivered.backgroundColor = UIColor.white
        } else {
            pickUp.isEnabled = true
            pickUp.setTitleColor(lightBlue, for: .normal)
            pickUp.backgroundColor = UIColor.white
            onRoute.isEnabled = true
            onRoute.setTitleColor(lightBlue, for: .normal)
            onRoute.backgroundColor = UIColor.white
            delivered.isEnabled = false
            delivered.setTitleColor(.white, for: .normal)
            delivered.backgroundColor = lightBlue
        }
        deliveryDateLabel(date: date.date)
        saveButtonState()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else {return}
        
        let name = self.name.text ?? "No Name"
        let address = self.address.text ?? "No Address"
        let trackingNumber = self.trackingNumber.text ?? "No Tracking Number"
        let status = self.status
        let date = self.date.date
        let notes = self.notes.text
        
        parcel = Parcel(receiverName: name, receiverAddress: address, recieverTrackingNumber: trackingNumber
            , deliveryStatus: status, deliveryDate: date, deliveryNotes: notes)
    }
    
    func deliveryDateLabel(date: Date) {
        dateTime.text = Parcel.deliveryDateTime.string(from: date)
    }

    func saveButtonState() {
        let nameText = name.text ?? ""
        let addressText = address.text ?? ""
        let trackingNumberText = trackingNumber.text ?? ""
        saveButton.isEnabled = ((!nameText.isEmpty && !addressText.isEmpty) && !trackingNumberText.isEmpty)
    }
    
    @IBAction func dateTimeChanged(_ sender: UIDatePicker) {
        deliveryDateLabel(date: date.date)
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        saveButtonState()
    }
    
    @IBAction func returnPressed(_ sender: UITextField) {
        name.resignFirstResponder()
    }
    
    @IBAction func pickUpPressed(_ sender: Any) {
        pickUp.isEnabled = false
        pickUp.setTitleColor(.white, for: .normal)
        pickUp.backgroundColor = lightBlue
        onRoute.isEnabled = true
        onRoute.setTitleColor(lightBlue, for: .normal)
        onRoute.backgroundColor = UIColor.white
        delivered.isEnabled = true
        delivered.setTitleColor(lightBlue, for: .normal)
        delivered.backgroundColor = UIColor.white
        status = "Pick Up"
    }
    
    @IBAction func onRoutePressed(_ sender: Any) {
        pickUp.isEnabled = true
        pickUp.setTitleColor(lightBlue, for: .normal)
        pickUp.backgroundColor = UIColor.white
        onRoute.isEnabled = false
        onRoute.setTitleColor(.white, for: .normal)
        onRoute.backgroundColor = lightBlue
        delivered.isEnabled = true
        delivered.setTitleColor(lightBlue, for: .normal)
        delivered.backgroundColor = UIColor.white
        status = "On Route"
    }
    
    @IBAction func deliveredPressed(_ sender: Any) {
        pickUp.isEnabled = true
        pickUp.setTitleColor(lightBlue, for: .normal)
        pickUp.backgroundColor = UIColor.white
        onRoute.isEnabled = true
        onRoute.setTitleColor(lightBlue, for: .normal)
        onRoute.backgroundColor = UIColor.white
        delivered.isEnabled = false
        delivered.setTitleColor(.white, for: .normal)
        delivered.backgroundColor = lightBlue
        status = "Delivered"
    }
    
}
