

import Foundation
@testable import SportsApp
class FakeNetwork
{
    let shouldReturnWithError : Bool
    
    
    let leagueResponse: [[String: Any]] = [
        [
            "league_key": 177,
            "league_name": "Premier League",
            "country_key": 44,
            "country_name": "England",
            "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/177_premier-league.png",
            "country_logo": "https://apiv2.allsportsapi.com/logo/logo_country/44_england.png"
        ],
        [
            "league_key": 302,
            "league_name": "La Liga",
            "country_key": 6,
            "country_name": "Spain",
            "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/302_la-liga.png",
            "country_logo": "https://apiv2.allsportsapi.com/logo/logo_country/6_spain.png"
        ],
        [
            "league_key": 168,
            "league_name": "Serie A",
            "country_key": 5,
            "country_name": "Italy",
            "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/168_serie-a.png",
            "country_logo": "https://apiv2.allsportsapi.com/logo/logo_country/5_italy.png"
        ]
    ]
   
    init(shouldReturnWithError: Bool) {
        self.shouldReturnWithError = shouldReturnWithError
    }
    
}

extension FakeNetwork {

    func loadData(url: String,
                  completionHandler: @escaping ([League]?, Error?) -> Void) {

        if shouldReturnWithError {
            completionHandler(nil, NSError(domain: "FakeNetwork", code: 1))
            return
        }

        var result: [League] = []

        for item in leagueResponse {

            let league = League(
                league_key:  item["league_key"] as? Int ?? 0,
                league_name: item["league_name"] as? String ?? "",
                country_key: item["country_key"] as? Int ?? 0,
                country_name: item["country_name"] as? String ?? "",
                league_logo: item["league_logo"] as? String ?? "",
                country_logo: item["country_logo"] as? String ?? ""
            )

            result.append(league)
        }

        completionHandler(result, nil)
    }
}
