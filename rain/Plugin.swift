import Cocoa

class Plugin {
    private var name: String = ""
    private var referenceUI: NSStatusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    private let referenceScript: Command = Command()
    private let action = Action()
    private var timer: Timer?
    private var cached: [String] = []

    init(name: String) {
        self.name = name
    }

    func start() {
        terminate()
        setTimer()
        initialize()
    }

    func terminate() {
        timer?.invalidate()
        referenceScript.terminate()
        referenceUI.menu?.removeAllItems()
    }

    func getMenu() -> NSMenu {
        if (self.referenceUI.menu == nil) {
            self.referenceUI.menu = NSMenu()
        }

        return self.referenceUI.menu!
    }

    @objc private func initialize() {
        DispatchQueue.global(qos: .background).async {
            self.referenceUI.menu?.addItem(NSMenuItem(title: "Updating", action: nil, keyEquivalent: ""))
            let output = self.referenceScript.executeScript(pluginFilename: self.name)
            var lines = output.components(separatedBy: CharacterSet.newlines).filter { $0 != "" }

            if lines.capacity <= 0 {
                return
            }

            DispatchQueue.main.async {
                self.referenceUI.button?.title = lines.removeFirst()
                lines.append("[separator]")
                lines.append("[update]")

                let ruleFactory = RuleFactory()
                self.referenceUI.menu = NSMenu()
                var prevLine = ""
                for line in lines {
                    let menuItem: MenuItem = ruleFactory.process(plugin: self, action: self.action, prevLine: prevLine, line: line)
                    prevLine = line

                    if menuItem.getMenuItem() != nil {
                        self.referenceUI.menu?.addItem(menuItem.getMenuItem()!)
                    }
                }

                self.notify(lines: lines)
            }
        }
    }

    private func notify(lines: [String]) {
        if (name.components(separatedBy: ".")[1].suffix(1) != "n") {
            return
        }

        let filteredLines = lines.filter { $0.prefix(1) != "[" || $0.hasPrefix("[link]") }
        if (cached.count == 0) {
            cached = filteredLines
            return
        }

        let count = filteredLines.count - Set(cached).intersection(Set(filteredLines)).count
        cached = filteredLines
        if (count == 0) {
            return
        }

        notification(count: count)
    }

    private func notification(count: Int) {
        let notification = NSUserNotification()
        notification.title = referenceUI.button?.title
        notification.informativeText = count == 1 ? "\(count) new notification" : "\(count) new notifications"
        notification.soundName = NSUserNotificationDefaultSoundName
        NSUserNotificationCenter.default.deliver(notification)
    }

    private func setTimer() {
        timer = Timer.scheduledTimer(timeInterval: TimeParse().parse(timeString: name.components(separatedBy: ".")[1]), target: self, selector: #selector(initialize), userInfo: nil, repeats: true)
    }
}
