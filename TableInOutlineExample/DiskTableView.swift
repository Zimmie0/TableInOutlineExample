//
//  DiskTableView.swift
//  TableInOutlineExample
//
//  Created by Zimmie on 5/29/22.
//

import Cocoa
import SwiftUI

class DiskTable: NSView, ObservableObject {
    @objc @Published dynamic var objectValue: Any?
    lazy var suiView: NSView = NSHostingView(rootView: ViewContents(wrapperView: self))

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        self.addSubview(self.suiView)
        suiView.translatesAutoresizingMaskIntoConstraints = false
        suiView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        suiView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        suiView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        suiView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        // Drawing code here.
    }

    struct ViewContents: View {
        @ObservedObject var wrapperView: DiskTable
        var body: some View {
            VStack {
                ForEach((wrapperView.objectValue as? HostedVM)?.disksArray ?? [], id: \.self) { item in
                    ObjectNamePlusIcon(object: item as HostedDisk)
                        .frame(height: 16.0, alignment: .leading)
                }
                Spacer(minLength: 0)
            }
            .padding(3)
        }
    }

    struct ObjectNamePlusIcon: View {
        let object: HostedDisk
        var body: some View {
            HStack {
                Image(systemName: "internaldrive")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color.black)
                .frame(width: 16.0, height: 16.0)
                Text(object.name)
            }
            .lineLimit(1)
            .padding(2)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
