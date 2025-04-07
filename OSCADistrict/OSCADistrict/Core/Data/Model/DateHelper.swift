import Foundation


extension FormatStyle where Self == Date.FormatStyle {
    func hourMinute() -> Date.FormatStyle {
        return .dateTime.hour().minute()
    }
    
    func dateOnly() -> Date.FormatStyle {
        return .dateTime.day(.twoDigits).month(.wide).year()
    }
    
    func monthYear() -> Date.FormatStyle {
        return .dateTime.month(.wide).year()
    }
    
    func weekdayDate() -> Date.FormatStyle {
        return .dateTime.weekday(.wide).dateOnly()
    }
}


extension Date {
    func dayDuration(_ secondDate: Date? = nil) -> Int {
        guard let secondDate = secondDate else {
            return 1
        }
        let day = Calendar.current.dateComponents([.day], from: self, to: secondDate).day!
        return day + 1
    }
    
    func isSameDay( _ date : Date? = nil) -> Bool {
        if let compareDate = date {
            if self.compare(toDate: compareDate, granularity: .day).rawValue != 0 {
                return false
            }
        }
        return true
    }
    
    func isSameDay( _ dates : [Date] = []) -> Bool {
        for compareDate in dates {
            if self.compare(toDate: compareDate, granularity: .day).rawValue != 0 {
                return false
            }
        }
        return true
    }
}
