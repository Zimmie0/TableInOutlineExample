//
//  HostedFolder.swift
//  TableInOutlineExample
//
//  Created by Zimmie on 5/29/22.
//

import Foundation
import CoreData

@objc(HostedFolder)
public class HostedFolder: HostedContainer {
	@NSManaged var contents: Set<HostedContainer>
}

let hostedFolderEntity: NSEntityDescription = {
	let entity = NSEntityDescription()
	entity.name = "HostedFolder"
	entity.managedObjectClassName = "HostedFolder"
	entity.properties.append({
		let relationship = NSRelationshipDescription()
		relationship.name = "contents"
		relationship.deleteRule = .cascadeDeleteRule
		relationship.maxCount = 0
		return relationship }())
	return entity
}()
