import Cocoa

class Link: Rule {
    private let action: Action
    private let line: String

    init(action: Action, line: String) {
        self.action = action
        self.line = line
    }

    func process() -> MenuItem {
        let components = line.components(separatedBy: "|")

        let menuItem = NSMenuItem()
        menuItem.title = components[0]
        menuItem.target = action
        menuItem.action = #selector(action.openWebpage)
        menuItem.representedObject = ["url": components[1]]

        return MenuItem(menuItem: menuItem)
    }
}
