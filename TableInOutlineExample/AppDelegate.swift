//
//  AppDelegate.swift
//  TableInOutlineExample
//
//  Created by Zimmie on 5/29/22.
//
// swiftlint:disable force_cast
// swiftlint:disable force_try

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    @IBOutlet var window: NSWindow!
    @IBOutlet var vmTreeView: NSOutlineView!
    @IBOutlet var treeController: NSTreeController!

    var tenantToShow: HostedFolder?
    let vmViewDelegate = VMOutlineDelegate()
    lazy var container: NSPersistentContainer = {
        let managedObjectModel = setUpManagedObjectModel()
        let container = NSPersistentContainer(
            name: "Table-in-Outline Example Container",
            managedObjectModel: managedObjectModel)
        container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? { fatalError("Unresolved error \(error), \(error.userInfo)") }
        })
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        return container }()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        vmTreeView.dataSource = vmViewDelegate
        vmTreeView.delegate = vmViewDelegate
        vmTreeView.usesAutomaticRowHeights = true
        objectFactory(context: container.viewContext)
        let tenantFetch = HostedFolder.fetchRequest()
        tenantFetch.fetchLimit = 1
        tenantFetch.predicate = NSPredicate(format: "parentFolder = nil")
        self.tenantToShow = (try! container.viewContext.fetch(tenantFetch) as! [HostedFolder])[0]
        treeController.bind(NSBindingName.content, to: tenantToShow!, withKeyPath: "contentsArray", options: nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    @IBAction func addADisk(sender: Any?) {
        let vmFetchRequest = HostedVM.fetchRequest()
        let allVMs = try! container.viewContext.fetch(vmFetchRequest) as! [HostedVM]
        for workingVM in allVMs {
            workingVM.disks.insert(newDiskWithName("New Disk", context: container.viewContext))
        }
        try? container.viewContext.save()
    }

    @IBAction func addANetworkAdapter(sender: Any?) {
        let vmFetchRequest = HostedVM.fetchRequest()
        let allVMs = try! container.viewContext.fetch(vmFetchRequest) as! [HostedVM]
        for workingVM in allVMs {
            workingVM.networkAdapters.insert(newNetworkAdapterWithName("New Network", context: container.viewContext))
        }
        try? container.viewContext.save()
    }
}
