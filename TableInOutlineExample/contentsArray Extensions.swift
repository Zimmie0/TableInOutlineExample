//
//  contentsArray Extensions.swift
//  TableInOutlineExample
//
//  Created by Zimmie on 5/29/22.
//

import Foundation
import CoreData

extension HostedFolder {
	@objc public override class func keyPathsForValuesAffectingValue(forKey key: String) -> Set<String> {
		switch key {
		case "contentsArray" :
			return Set(["contents"])
		default :
			return super.keyPathsForValuesAffectingValue(forKey: key)
		}
	}
	@objc public dynamic var contentsArray: [HostedContainer] {
		return contents.sorted {
			return $0.name.compare($1.name, options: [.numeric]) == .orderedAscending
		}
	}
}

extension HostedVM {
	@objc public dynamic var contentsArray: [HostedContainer]? {
		nil
	}
}

extension HostedContainer {
	@objc public var rowHeight: CGFloat {
		return CGFloat(24)
	}
}

extension HostedFolder {
	@objc override public var rowHeight: CGFloat {
		return CGFloat(24)
	}
}

extension HostedVM {
	@objc override public var rowHeight: CGFloat {
		let maxCount = [
			self.disks.count,
			self.networkAdapters.count,
			1
		].max()!
		return CGFloat(maxCount * 24)
	}
}
