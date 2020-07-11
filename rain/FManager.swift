import Cocoa

class FManager {
    let command: Command = Command()

    func getPlugins() -> [String] {
        if (!folderExists(path: Path.plugins)) {
            return []
        }

        return getPluginFiles()
    }

    func createFolderIfNotExists() -> Void {
        if (!folderExists(path: Path.plugins)) {
            try? FileManager.default.createDirectory(atPath: Path.plugins, withIntermediateDirectories: false, attributes: nil)
        }
    }

    func makeExecutable(name: String) {
        let filePath = "\(Path.plugins)/\(name)"
        if (!FileManager.default.isExecutableFile(atPath: filePath)) {
            try? FileManager.default.setAttributes([.posixPermissions: 0o700], ofItemAtPath: filePath)
        }
    }

    private func folderExists(path: String) -> Bool {
        FileManager.default.fileExists(atPath: path)
    }

    private func getPluginFiles() -> [String] {
        let files = try? FileManager.default.contentsOfDirectory(atPath: Path.plugins)
        var plugins: [String] = []

        for file in files! {
            if (file.hasSuffix(".sh") && file.components(separatedBy: ".").count == 3) {
                plugins.append(file)
            }
        }

        return plugins
    }
}
