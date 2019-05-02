//
//  ParcelsListTableViewController.swift
//  Parcel Delivery
//
//  Created by alcoderithm on 5/4/19.
//  Copyright © 2019 alcoderithm. All rights reserved.
//

import UIKit

class ParcelsListTableViewController: UITableViewController, ParcelCellDelegate {
    
    var parcels = [Parcel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedParcels = Parcel.loadParcels(){
            parcels = savedParcels
        }
        else {
            parcels = Parcel.loadSampleParcels()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parcels.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ParcelsListIdentifier") as? ParcelCellTableViewCell else {
            fatalError("Could not dequeue a cell")
        }
        
        let parcel = parcels[indexPath.row]
        cell.name?.text = "   " + parcel.receiverName
        cell.address?.text = "    " + parcel.receiverAddress
        cell.status.text = parcel.deliveryStatus
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            parcels.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            Parcel.saveParcels(parcels)
        }
    }
    
    @IBAction func unwindParcelsListDelivery(segue: UIStoryboardSegue){
        guard segue.identifier == "saveUnwind" else {return}
        let sourceViewController = segue.source as! ParcelDetailViewController
        
        if let parcel = sourceViewController.parcel{
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                parcels[selectedIndexPath.row] = parcel
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                let newIndexPath = IndexPath(row: parcels.count, section: 0 )
                parcels.append(parcel)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
        Parcel.saveParcels(parcels)
    }
    
    @IBAction func unwindToDelete(segue: UIStoryboardSegue){
        guard segue.identifier == "deleteUnwind" else {return}
        let sourceViewController = segue.source as! ParcelDetailViewController
        
        if let parcel = sourceViewController.parcel{
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                parcels[selectedIndexPath.row] = parcel
                parcels.remove(at: selectedIndexPath.row)
                tableView.deleteRows(at: [selectedIndexPath], with: .fade)
                Parcel.saveParcels(parcels)
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  "showDetails" {
            let parcelViewController = segue.destination as! ParcelDetailViewController
            let indexPath = tableView.indexPathForSelectedRow!
            let selectedParcel = parcels[indexPath.row]
            parcelViewController.parcel = selectedParcel
        }
    }

}
