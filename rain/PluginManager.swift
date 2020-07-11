import Cocoa

class PluginManager {
    let fManager: FManager = FManager()
    var plugins: [Plugin] = []

    func start() {
        terminate()
        initialize()
        execute()
    }

    func terminate() {
        plugins.forEach { $0.terminate() }
        plugins = []
    }

    private func initialize() {
        let pluginFiles = fManager.getPlugins()

        for pluginFile in pluginFiles {
            fManager.makeExecutable(name: pluginFile)
            plugins.append(Plugin(name: pluginFile))
        }
    }

    private func execute() {
        plugins.forEach { $0.start() }
    }
}
