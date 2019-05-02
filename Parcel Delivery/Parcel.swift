//
//  ParcelsList.swift
//  Parcel Delivery
//
//  Created by alcoderithm on 5/4/19.
//  Copyright © 2019 alcoderithm. All rights reserved.
//

import Foundation

struct Parcel: Codable{
    var receiverName: String
    var receiverAddress: String
    var recieverTrackingNumber: String
    var deliveryStatus: String
    var deliveryDate: Date
    var deliveryNotes: String?
    
    static let deliveryDateTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("parcels").appendingPathExtension("plist")
    
    static func loadParcels() -> [Parcel]? {
        guard let codedParcels = try? Data(contentsOf: ArchiveURL) else {return nil}
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<Parcel>.self, from: codedParcels)
    }
    
    static func loadSampleParcels() -> [Parcel] {
        let parcel1 = Parcel(receiverName: "Billy Rey Caballero", receiverAddress: "Compassvale Drive, Singapore", recieverTrackingNumber: "TN1234567890", deliveryStatus: "On Route", deliveryDate: Date(), deliveryNotes: "Your parcel is on the way.")
        return [parcel1]
    }
    
    static func saveParcels(_ parcels: [Parcel]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedParcels = try? propertyListEncoder.encode(parcels)
        try? codedParcels?.write(to: ArchiveURL, options: .noFileProtection)
    }
}
