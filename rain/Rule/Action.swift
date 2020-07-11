import Cocoa

class Action {
    @objc func openWebpage(sender: NSMenuItem) {
        let url = (sender.representedObject as? Dictionary<String, String>)!["url"]!
        NSWorkspace.shared.open(URL(string: url)!)
    }

    @objc func update(sender: NSMenuItem) {
        (sender.representedObject as? Dictionary<String, Plugin>)!["plugin"]!.start()
    }
}
