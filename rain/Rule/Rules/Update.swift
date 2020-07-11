import Cocoa

class Update: Rule {
    private let action: Action
    private let plugin: Plugin

    init(plugin: Plugin, action: Action) {
        self.plugin = plugin
        self.action = action
    }

    func process() -> MenuItem {
        let menuItem = NSMenuItem()
        menuItem.title = "Update"
        menuItem.target = action
        menuItem.action = #selector(action.update)
        menuItem.representedObject = ["plugin": plugin]

        return MenuItem(menuItem: menuItem)
    }
}
