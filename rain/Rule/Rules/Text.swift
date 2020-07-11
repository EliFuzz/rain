import Cocoa

class Text: Rule {
    private let line: String

    init(line: String) {
        self.line = line
    }

    func process() -> MenuItem {
        let menuItem = NSMenuItem()
        menuItem.title = line

        return MenuItem(menuItem: menuItem)
    }
}
