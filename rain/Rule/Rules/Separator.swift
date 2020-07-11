import Cocoa

class Separator: Rule {
    func process() -> MenuItem {
        MenuItem(menuItem: NSMenuItem.separator())
    }
}
