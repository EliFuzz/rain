import Cocoa

class MenuItem {
    private let menuItem: NSMenuItem?

    init(menuItem: NSMenuItem? = nil) {
        self.menuItem = menuItem
    }

    func getMenuItem() -> NSMenuItem? {
        self.menuItem
    }
}
