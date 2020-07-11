import Cocoa

@NSApplicationMain class AppDelegate: NSObject, NSApplicationDelegate {

    let fManager: FManager = FManager()
    let pluginManager: PluginManager = PluginManager()
    let menu: Menu = Menu()

    override func awakeFromNib() {
        super.awakeFromNib()

        menu.render()
        menu.addMenuItem(title: "Update all", target: self, action: #selector(update))
        menu.addMenuItem(title: "Open plugins folder", target: self, action: #selector(openPluginsFolder))
        menu.addMenuItem(title: "Quit", target: self, action: #selector(exit))

        pluginManager.start()
    }

    @objc private func update() {
        reset()
    }

    @objc private func openPluginsFolder() {
        fManager.createFolderIfNotExists()
        NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: Path.plugins)
    }

    @objc private func exit() {
        pluginManager.terminate()
        NSApplication.shared.terminate(self)
    }

    private func reset() {
        pluginManager.start()
    }
}

extension AppDelegate: NSUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
        true
    }
}
