//
//  Outline Delegate.swift
//  TableInOutlineExample
//
//  Created by Zimmie on 5/29/22.
//

import Foundation
import Cocoa
import SwiftUI

class VMOutlineDelegate: NSObject,
						 NSOutlineViewDataSource,
						 NSOutlineViewDelegate {
	// MARK: - NSOutlineViewDataSource
	func outlineView(
		_ outlineView: NSOutlineView,
		isGroupItem item: Any)
	-> Bool {
		if (item as? NSTreeNode)?.representedObject is HostedFolder {
			return true
		} else {
			return false
		}
	}

	// MARK: - NSOutlineViewDelegate
	func outlineView(
		_ outlineView: NSOutlineView,
		viewFor tableColumn: NSTableColumn?,
		item: Any)
	-> NSView? {
		let identifier = tableColumn?.identifier ?? NSUserInterfaceItemIdentifier("Group Item (Section)")
		if let view = outlineView.makeView(withIdentifier: identifier, owner: self) { return view }
		guard let workingItem = (item as? NSTreeNode)?.representedObject as? HostedContainer
		else { return nil }
		if let workingItem = workingItem as? HostedFolder {
			return NSHostingView(rootView: SectionLabel(name: workingItem.name))
		}
		print("It's not a section somehow?")
		return nil
	}
}

struct SectionLabel: View {
	var name: String
	var body: some View {
		Text(name)
			.frame(maxWidth: .infinity, alignment: .leading)
			.lineLimit(1)
			.padding(3.0)
	}
}
