import Cocoa

class RuleFactory {

    func process(plugin: Plugin, action: Action, prevLine: String, line: String) -> MenuItem {
        let rule = build(plugin: plugin, action: action, prevLine: prevLine, line: line)

        return rule.process()
    }

    private func build(plugin: Plugin, action: Action, prevLine: String, line: String) -> Rule {
        if (line.prefix(1) != "[") {
            return Text(line: line)
        }

        switch String(line[..<line.range(of: "]")!.upperBound]) {
        case "[link]":
            return Link(action: action, line: String(line[line.range(of: "]")!.upperBound...]))
        case "[separator]":
            return Separator()
        case "[menu]":
            return SubMenu(plugin: plugin, action: action, prevLine: prevLine, line: line)
        case "[update]":
            return Update(plugin: plugin, action: action)
        default:
            return Text(line: String(line[line.range(of: "]")!.upperBound...]))
        }
    }
}
