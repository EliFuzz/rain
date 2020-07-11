import Cocoa

class Command {
    var reference: Process = Process()

    func executeScript(pluginFilename: String) -> String {
        bash(command: ["\(Path.plugins)/\(pluginFilename)"])
    }

    func terminate() {
        if reference.isRunning {
            reference.interrupt()
            reference.terminate()
        }
    }

    private func bash(command: [String]) -> String {
        terminate()

        reference = Process()
        reference.executableURL = URL(fileURLWithPath: "/usr/bin/env")
        reference.arguments = command

        let outputPipe = Pipe()
        reference.standardOutput = outputPipe

        try? reference.run()

        return String(decoding: outputPipe.fileHandleForReading.readDataToEndOfFile(), as: UTF8.self)
    }
}
