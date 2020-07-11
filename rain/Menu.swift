import Cocoa

class Menu {
    let menu: NSStatusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

    func render() {
        menu.button?.title = "⛩️"
        menu.menu = NSMenu()
    }

    func addMenuItem(title: String, target: AnyObject, action: Selector) {
        let menuItem = NSMenuItem()
        menuItem.title = title
        menuItem.target = target
        menuItem.action = action

        menu.menu?.addItem(menuItem)
    }
}
