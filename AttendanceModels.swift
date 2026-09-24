import Foundation

// MARK: - Check-In Model

struct CheckIn {
    let name: String
    let time: String
    let durationInMinutes: Int?
}

// MARK: - Validation Errors

enum CheckInError: Error {
    case emptyName
    case badTime
    case badDuration
}

// MARK: - Validator

func validate(_ checkIn: CheckIn) throws -> CheckIn {
    
    // Validate name
    let cleanedName = checkIn.name.trimmingCharacters(in: .whitespacesAndNewlines)
    
    guard !cleanedName.isEmpty else {
        throw CheckInError.emptyName
    }
    
    // Validate time
    let timeParts = checkIn.time.split(separator: ":")
    
    guard timeParts.count == 2,
          let hour = Int(timeParts[0]),
          let minute = Int(timeParts[1]),
          hour >= 0,
          hour <= 23,
          minute >= 0,
          minute <= 59 else {
        throw CheckInError.badTime
    }
    
    // Validate duration
    guard let duration = checkIn.durationInMinutes,
          duration >= 0 else {
        throw CheckInError.badDuration
    }
    
    // Return cleaned CheckIn
    return CheckIn(
        name: cleanedName,
        time: checkIn.time,
        durationInMinutes: duration
    )
}


// MARK: - Int Extension

extension Int {
    
    var hoursAndMinutes: String {
        let hours = self / 60
        let minutes = self % 60
        
        if hours == 0 {
            return "\(minutes)m"
        } else if minutes == 0 {
            return "\(hours)h"
        } else {
            return "\(hours)h \(minutes)m"
        }
    }
}
// Validates and cleans a gym check-in record before it is processed.
