//
//  HostedContainer.swift
//  TableInOutlineExample
//
//  Created by Zimmie on 5/29/22.
//

import Foundation
import CoreData

@objc(HostedContainer)
public class HostedContainer: NSManagedObject {
	@NSManaged var id: UUID
	@NSManaged var name: String

	@NSManaged var parentFolder: HostedFolder?
}

let hostedContainerEntity: NSEntityDescription = {
	let entity = NSEntityDescription()
	entity.name = "HostedContainer"
	entity.managedObjectClassName = "HostedContainer"
	entity.properties.append(generateAttribute(
		name: "id",
		type: .UUIDAttributeType))
	entity.properties.append(generateAttribute(
		name: "name",
		type: .stringAttributeType))
	entity.properties.append({
		let relationship = NSRelationshipDescription()
		relationship.name = "parentFolder"
		relationship.deleteRule = .nullifyDeleteRule
		relationship.maxCount = 1
		return relationship }())
	return entity
}()
