import Cocoa

class TimeParse {
    func parse(timeString: String) -> Double {
        let time = (timeString as NSString).doubleValue
        let period = timeString.components(separatedBy: CharacterSet.decimalDigits).joined().prefix(1)

        switch period {
        case "s":
            return time
        case "m":
            return time * 60
        case "h":
            return time * 3600
        case "d":
            return time * 86400
        default:
            return 60
        }
    }
}
