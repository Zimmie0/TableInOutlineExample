//
//  HostedDisk.swift
//  TableInOutlineExample
//
//  Created by Zimmie on 5/29/22.
//

import Foundation
import CoreData

@objc(HostedDisk)
public class HostedDisk: NSManagedObject {
	@NSManaged var id: UUID
	@NSManaged var name: String
	@NSManaged var capacityInKilobytes: Int32

	@NSManaged var inVM: HostedVM
}

let hostedDiskEntity: NSEntityDescription = {
	let entity = NSEntityDescription()
	entity.name = "HostedDisk"
	entity.managedObjectClassName = "HostedDisk"
	entity.properties.append(generateAttribute(
		name: "id",
		type: .UUIDAttributeType))
	entity.properties.append(generateAttribute(
		name: "name",
		type: .stringAttributeType))
	entity.properties.append(generateAttribute(
		name: "capacityInKilobytes",
		type: .integer32AttributeType))
	entity.properties.append({
		let relationship = NSRelationshipDescription()
		relationship.name = "inVM"
		relationship.deleteRule = .nullifyDeleteRule
		relationship.maxCount = 1
		return relationship }())
	return entity
}()
