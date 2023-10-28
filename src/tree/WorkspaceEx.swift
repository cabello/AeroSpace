extension Workspace {
    var rootTilingContainer: TilingContainer {
        let containers = children.filterIsInstance(of: TilingContainer.self)
        switch containers.count {
        case 0:
            let orientation: Orientation
            switch config.defaultRootContainerOrientation {
            case .horizontal:
                orientation = .h
            case .vertical:
                orientation = .v
            case .auto:
                orientation = monitor.lets { $0.width >= $0.height } ? .h : .v
            }
            return TilingContainer(parent: self, adaptiveWeight: 1, orientation, config.defaultRootContainerLayout, index: INDEX_BIND_LAST)
        case 1:
            return containers.singleOrNil()!
        default:
            error("Workspace must contain zero or one tiling container as its child")
        }
    }

    static var focused: Workspace { Workspace.get(byName: focusedWorkspaceName) } // todo drop?

    var floatingWindows: [Window] {
        workspace.children.filterIsInstance(of: Window.self)
    }
}
