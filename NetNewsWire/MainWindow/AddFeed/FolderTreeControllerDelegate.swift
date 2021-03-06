//
//  FolderTreeControllerDelegate.swift
//  NetNewsWire
//
//  Created by Brent Simmons on 8/10/16.
//  Copyright © 2016 Ranchero Software, LLC. All rights reserved.
//

import Foundation
import RSCore
import RSTree
import Articles
import Account

final class FolderTreeControllerDelegate: TreeControllerDelegate {

	func treeController(treeController: TreeController, childNodesFor node: Node) -> [Node]? {

		return node.isRoot ? childNodesForRootNode(node) : nil
	}
}

private extension FolderTreeControllerDelegate {

	func childNodesForRootNode(_ node: Node) -> [Node]? {

		// Root node is “Top Level” and children are folders. Folders can’t have subfolders.
		// This will have to be revised later.

		guard let folders = AccountManager.shared.localAccount.folders else {
			return nil
		}
		let folderNodes = folders.map { createNode($0, parent: node) }
		return folderNodes.sortedAlphabetically()
	}

	func createNode(_ folder: Folder, parent: Node) -> Node {

		let node = Node(representedObject: folder, parent: parent)
		node.canHaveChildNodes = false
		return node
	}
}
