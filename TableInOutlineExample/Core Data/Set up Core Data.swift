//
//  Set up Core Data.swift
//  TableInOutlineExample
//
//  Created by Zimmie on 5/29/22.
//
// swiftlint:disable opening_brace

import Foundation
import CoreData

func setUpManagedObjectModel()
-> NSManagedObjectModel {
	hostedContainerEntity.subentities.append(hostedFolderEntity)
	hostedContainerEntity.subentities.append(hostedVMEntity)

	buildRelationship(
		entity1: hostedFolderEntity, key1: "contents",
		entity2: hostedContainerEntity, key2: "parentFolder")
	buildRelationship(
		entity1: hostedVMEntity, key1: "disks",
		entity2: hostedDiskEntity, key2: "inVM")
	buildRelationship(
		entity1: hostedVMEntity, key1: "networkAdapters",
		entity2: hostedNetworkAdapterEntity, key2: "inVM")

	let managedObjectModel = NSManagedObjectModel()
	managedObjectModel.entities.append(hostedContainerEntity)
	managedObjectModel.entities.append(hostedFolderEntity)
	managedObjectModel.entities.append(hostedVMEntity)
	managedObjectModel.entities.append(hostedDiskEntity)
	managedObjectModel.entities.append(hostedNetworkAdapterEntity)
	return managedObjectModel
}

func generateAttribute(
	name: String,
	type: NSAttributeType,
	defaultValue: Any? = nil)
-> NSAttributeDescription {
	let property = NSAttributeDescription()
	property.name = name
	property.attributeType = type
	property.defaultValue = defaultValue
	return property
}

func buildRelationship(
	entity1: NSEntityDescription,
	key1: String,
	entity2: NSEntityDescription,
	key2: String)
{
	let relationship1 = entity1.relationshipsByName[key1]!
	let relationship2 = entity2.relationshipsByName[key2]!
	relationship1.destinationEntity = entity2
	relationship1.inverseRelationship = relationship2
	relationship2.destinationEntity = entity1
	relationship2.inverseRelationship = relationship1
}
