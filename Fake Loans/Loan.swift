//
//  Loan.swift
//  Fake Loans
//
//  Created by Sorfian on 25/03/23.
//

import Foundation

struct Loan: Hashable, Codable {
    var name: String = ""
    var country: String = ""
    var use: String = ""
    var amount: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case name
        case country = "location"
        case use
        case amount = "loan_amount"
    }
    
    enum LocationKeys: String, CodingKey {
        case country
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        
        let location = try container.nestedContainer(keyedBy: LocationKeys.self, forKey: .country)
        self.country = try location.decode(String.self, forKey: .country)
        
        self.use = try container.decode(String.self, forKey: .use)
        self.amount = try container.decode(Int.self, forKey: .amount)
    }
}

struct LoanDataStore: Codable {
    var loans: [Loan]
}
