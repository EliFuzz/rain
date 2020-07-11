import Cocoa

class SubMenu: Rule {
    private let plugin: Plugin
    private let action: Action
    private let prevLine: String
    private let line: String

    init(plugin: Plugin, action: Action, prevLine: String, line: String) {
        self.plugin = plugin
        self.action = action
        self.prevLine = prevLine
        self.line = line
    }

    func process() -> MenuItem {
        let currentLine = String(line[line.range(of: "]")!.upperBound...])

        if prevLine.starts(with: "[menu]") {
            let menuIndex: Int? = plugin.getMenu().items.lastIndex(where: { $0.hasSubmenu })
            let menuItem: NSMenuItem? = RuleFactory().process(plugin: plugin, action: action, prevLine: prevLine, line: currentLine).getMenuItem()

            self.plugin.getMenu().item(at: menuIndex!)?.submenu?.addItem(menuItem!)

            return MenuItem()
        }

        let item = NSMenuItem()
        item.title = currentLine
        item.submenu = NSMenu()
        plugin.getMenu().addItem(item)

        return MenuItem()
    }
}
