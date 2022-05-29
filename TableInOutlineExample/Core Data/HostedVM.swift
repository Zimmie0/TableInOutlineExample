//
//  HostedVM.swift
//  TableInOutlineExample
//
//  Created by Zimmie on 5/29/22.
//

import Foundation
import CoreData

@objc(HostedVM)
public class HostedVM: HostedContainer {
	@NSManaged var state: String
	@NSManaged var comments: String

	@NSManaged var disks: Set<HostedDisk>
	@NSManaged var networkAdapters: Set<HostedNetworkAdapter>

    @objc public dynamic var disksArray: [HostedDisk] {
        return disks.sorted {
            $0.name < $1.name
        }
    }
    @objc public dynamic var networkAdaptersArray: [HostedNetworkAdapter] {
        return networkAdapters.sorted {
            $0.name < $1.name
        }
    }
}

let hostedVMEntity: NSEntityDescription = {
	let entity = NSEntityDescription()
	entity.name = "HostedVM"
	entity.managedObjectClassName = "HostedVM"
	entity.properties.append(generateAttribute(
		name: "state",
		type: .stringAttributeType))
	entity.properties.append(generateAttribute(
		name: "comments",
		type: .stringAttributeType))
	entity.properties.append({
		let relationship = NSRelationshipDescription()
		relationship.name = "disks"
		relationship.deleteRule = .cascadeDeleteRule
		relationship.maxCount = 0
		return relationship }())
	entity.properties.append({
		let relationship = NSRelationshipDescription()
		relationship.name = "networkAdapters"
		relationship.deleteRule = .cascadeDeleteRule
		relationship.maxCount = 0
		return relationship }())
	return entity
}()
