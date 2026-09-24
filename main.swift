import Foundation


let rawCheckIns: [CheckIn] = [
    CheckIn(
        name: "Sreekar",
        time: "17:30",
        durationInMinutes: 75
    ),
    
    CheckIn(
        name: "Rahul",
        time: "18:00",
        durationInMinutes: 60
    ),
    
    CheckIn(
        name: "Ananya",
        time: "07:15",
        durationInMinutes: 90
    ),
    
    // Broken: empty name
    CheckIn(
        name: "   ",
        time: "08:30",
        durationInMinutes: 45
    ),
    
    // Broken: invalid hour
    CheckIn(
        name: "Arjun",
        time: "27:00",
        durationInMinutes: 60
    ),
    
    CheckIn(
        name: "Priya",
        time: "19:15",
        durationInMinutes: 80
    ),
    
    // Broken: nil duration
    CheckIn(
        name: "Kiran",
        time: "20:00",
        durationInMinutes: nil
    ),
    
    // Broken: negative duration
    CheckIn(
        name: "Vikram",
        time: "16:45",
        durationInMinutes: -30
    ),
    
    CheckIn(
        name: "Meera",
        time: "06:30",
        durationInMinutes: 120
    )
]


// MARK: - Valid and Flagged Records

var validVisits: [CheckIn] = []

var flagged: [(record: CheckIn, error: CheckInError)] = []


// MARK: - Validate Using do-catch

for record in rawCheckIns {
    
    do {
        let validRecord = try validate(record)
        validVisits.append(validRecord)
        
    } catch let error as CheckInError {
        flagged.append((record: record, error: error))
    } catch {
        print("Unexpected error:", error)
    }
}


// MARK: - Calculate Total Duration Using reduce
let totalDuration = validVisits.reduce(0) { total, visit in
    total + (visit.durationInMinutes ?? 0)
}


// MARK: - Count Flagged Records

let flaggedCount = flagged.reduce(0) { count, _ in
    count + 1
}


// MARK: - Error Description

func errorMessage(for error: CheckInError) -> String {
    
    switch error {
    case .emptyName:
        return "Empty name"
        
    case .badTime:
        return "Bad time"
        
    case .badDuration:
        return "Bad duration"
    }
}


// MARK: - Final Report

print("========== GYM ATTENDANCE REPORT ==========")

print("\nVALID VISITS: \(validVisits.count)")

for visit in validVisits {
    
    let duration = visit.durationInMinutes ?? 0
    
    print(
        "\(visit.name) | \(visit.time) | \(duration.hoursAndMinutes)"
    )
}

print("\nTOTAL VALID DURATION: \(totalDuration.hoursAndMinutes)")

print("\nFLAGGED RECORDS: \(flaggedCount)")

for item in flagged {
    
    print(
        "\(item.record.name) | \(item.record.time) | \(errorMessage(for: item.error))"
    )
}

print("\n===========================================")
// The final report summarizes valid visits and flagged records.
