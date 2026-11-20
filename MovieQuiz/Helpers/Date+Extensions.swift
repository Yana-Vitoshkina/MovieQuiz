import Foundation

extension Date {
    
    private static let dateTimeDefaultFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YY HH:mm"
        return dateFormatter
    }()
    
    var dateTimeString: String { Self.dateTimeDefaultFormatter.string(from: self) }
}

