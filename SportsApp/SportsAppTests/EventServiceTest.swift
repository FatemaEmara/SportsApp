//
//  EventServiceTest.swift
//  SportsAppTests
//
//  Created by Eyad waleed on 13/05/2026.
//

import XCTest
@testable import SportsApp
final class EventServiceTest: XCTestCase {
    var eventService: FixturesDataImp!

       override func setUp() {
           eventService = FixturesDataImp()
       }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func test_fetchUpcomingMatches() {
           let expectation = expectation(description: "Upcoming matches")

        eventService.fetchUpcomingMatches(leagueId: 177, sport: Sport.football) { result in
               switch result {
               case .success(let events):
                   print("✅ Upcoming: \(events.count) matches")
                   XCTAssertFalse(events.isEmpty)
               case .failure(let error as SportsError):
                   // noData is acceptable — maybe no matches today
                   XCTAssertEqual(error, .noData)
               case .failure(let error):
                   XCTFail("Unexpected error: \(error)")
               }
               expectation.fulfill()
           }

           waitForExpectations(timeout: 10)
       }

       func test_fetchLatestMatches() {
           let expectation = expectation(description: "Latest matches")

           eventService.fetchLatestMatches(leagueId: 177,sport: Sport.football) { result in
               switch result {
               case .success(let events):
                   print("✅ Latest: \(events.count) matches")
                   XCTAssertFalse(events.isEmpty)
               case .failure(let error as SportsError):
                   XCTAssertEqual(error, .noData)
               case .failure(let error):
                   XCTFail("Unexpected error: \(error)")
               }
               expectation.fulfill()
           }

           waitForExpectations(timeout: 10)
       }

       func test_fetchTeams() {
           let expectation = expectation(description: "Teams")

           eventService.fetchTeamsData(leagueId: 177,sport: Sport.football) { result in
               switch result {
               case .success(let teams):
                   print("✅ Teams: \(teams.count)")
                   XCTAssertFalse(teams.isEmpty)
               case .failure(let error):
                   XCTFail("Failed: \(error)")
               }
               expectation.fulfill()
           }

           waitForExpectations(timeout: 10)
       }

}
