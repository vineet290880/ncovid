//
//  CovidModel.swift
//  ncovid19
//
//  Created by Vineet Pathak on 2020-04-16.
//  Copyright © 2020 Vineet Pathak. All rights reserved.
//

import Foundation

// MARK: - CovidModel
struct CovidModel: Codable {
    let data: DataClass
    let cacheHit: Bool

    enum CodingKeys: String, CodingKey {
        case data
        case cacheHit = "_cacheHit"
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let coordinates: Coordinates
    let name, code: String
    let population: Int
    let updatedAt: String
    let today: Today
    let latestData: LatestData
    let timeline: [Timeline]

    enum CodingKeys: String, CodingKey {
        case coordinates, name, code, population
        case updatedAt = "updated_at"
        case today
        case latestData = "latest_data"
        case timeline
    }
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let latitude, longitude: Float
}

// MARK: - LatestData
struct LatestData: Codable {
    let deaths, confirmed, recovered, critical: Int
    let calculated: Calculated
}

// MARK: - Calculated
struct Calculated: Codable {
    let deathRate, recoveryRate: Double
    let recoveredVsDeathRatio: JSONNull?
    let casesPerMillionPopulation: Int

    enum CodingKeys: String, CodingKey {
        case deathRate = "death_rate"
        case recoveryRate = "recovery_rate"
        case recoveredVsDeathRatio = "recovered_vs_death_ratio"
        case casesPerMillionPopulation = "cases_per_million_population"
    }
}

// MARK: - Timeline
struct Timeline: Codable {
    let updatedAt, date: String
    let deaths, confirmed, active, recovered: Int
    let newConfirmed, newRecovered, newDeaths: Int
    let isInProgress: Bool?

    enum CodingKeys: String, CodingKey {
        case updatedAt = "updated_at"
        case date, deaths, confirmed, active, recovered
        case newConfirmed = "new_confirmed"
        case newRecovered = "new_recovered"
        case newDeaths = "new_deaths"
        case isInProgress = "is_in_progress"
    }
}

// MARK: - Today
struct Today: Codable {
    let deaths, confirmed: Int
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
