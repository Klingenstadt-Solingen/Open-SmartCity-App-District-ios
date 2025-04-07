//
//  AuxiliaryFile.swift
//  OSCADistrict
//
//  Created by ronny aretz on 10.10.24.
//
import Foundation

/// Represents a file with its metadata and access information.
struct AuxiliaryFile: BaseModel {
    /// The unique identifier for the file.
    let id: String
    let name: String?
    let fileName: String
    let text: String
    let date: Date
    let size: UInt
    let sha512Checksum: String
    let mimeType: String?
    let accessUrl: String
    let downloadUrl: String?
    /// A URL to more information about the file if available.
    let webUrl: String?
    /// The timestamp of the last update made to the file's details.
    let updatedAt: Date
    /// The timestamp when the file was created in the system.
    let createdAt: Date
}

