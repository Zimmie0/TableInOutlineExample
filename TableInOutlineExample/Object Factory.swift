//
//  Object Factory.swift
//  TableInOutlineExample
//
//  Created by Zimmie on 5/29/22.
//

import Foundation
import CoreData

func objectFactory(context: NSManagedObjectContext) {
	let newTenant = HostedFolder(context: context)
	newTenant.id = UUID()
	newTenant.name = "Tenant"
	for count in 1...Int.random(in: 2...5) {
		newTenant.contents.insert(newVMWithName(
			"VM \(count)",
			context: context))
	}
	for folderCount in 1...Int.random(in: 10...20) {
		newTenant.contents.insert(newFolderWithName(
			"folder \(folderCount)",
			context: context))
	}
	try? context.save()
}

func newFolderWithName(
	_ name: String,
	context: NSManagedObjectContext)
-> HostedFolder {
	let newFolder = HostedFolder(context: context)
	newFolder.id = UUID()
	newFolder.name = name
	for vmCount in 1...Int.random(in: 10...20) {
		newFolder.contents.insert(newVMWithName(
			"\(newFolder.name) VM \(vmCount)",
			context: context))
	}
	return newFolder
}

func newVMWithName(
	_ name: String,
	context: NSManagedObjectContext)
-> HostedVM {
	let newVM = HostedVM(context: context)
	newVM.id = UUID()
	newVM.name = name
	newVM.state = Bool.random() ? "Running" : "Stopped"
	newVM.comments = newVM.id.uuidString
	for diskNumber in 1...Int.random(in: 1...5) {
		newVM.disks.insert(
			newDiskWithName(
				"\(newVM.name) disk \(diskNumber)",
				context: context))
	}
	for netNumber in 1...Int.random(in: 1...5) {
		newVM.networkAdapters.insert(
			newNetworkAdapterWithName(
				"\(newVM.name) network \(netNumber)",
				context: context))
	}
	return newVM
}

func newDiskWithName(
	_ name: String,
	context: NSManagedObjectContext)
-> HostedDisk {
	let newDisk = HostedDisk(context: context)
	newDisk.id = UUID()
	newDisk.name = name
	newDisk.capacityInKilobytes = Int32.random(in: 1024...1048576)
	return newDisk
}

func newNetworkAdapterWithName(
	_ name: String,
	context: NSManagedObjectContext)
-> HostedNetworkAdapter {
	let newNet = HostedNetworkAdapter(context: context)
	newNet.id = UUID()
	newNet.name = name
	newNet.ipv4Address = "10.\(Int.random(in: 0...255)).\(Int.random(in: 0...255)).0"
	newNet.ipv4MaskLength = 24
	return newNet
}
