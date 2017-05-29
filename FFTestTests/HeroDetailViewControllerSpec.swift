//
//  FFTestTests.swift
//  FFTestTests
//
//  Created by Francisco Amado on 26/05/2017.
//  Copyright © 2017 franciscoamado. All rights reserved.
//

@testable import FFTest
import Quick
import Nimble

class HeroDetailViewControllerSpec: QuickSpec {
    
    override func spec() {
        
        var detailVC: HeroDetailViewController!
        var hero: Hero!
        
        let mockComic = Comic(name: "Comic", resourceURI: "image_Comic")
        let mockStory = Story(name: "Story", resourceURI: "image_Story", type: "cover")
        let mockEvent = Event(name: "Event", resourceURI: "image_Event")
        let mockSeries = Series(name: "Series", resourceURI: "image_Series")
        
        beforeEach {
            
            hero = Hero(id: 3005, name: "Test", description: "Test description",
                                modified: nil, resourceURI: nil, thumbnail: nil,
                                comics: [mockComic], stories: [mockStory],
                                events: [mockEvent], series: [mockSeries])
            
            detailVC = HeroDetailViewController(with: hero)
            let _ = detailVC.view
        }
        
        describe("HeroDetailVC Extension") {
            context("the parsed function") {
                it("returns the summary title and list") {
                    
                    // The expected title should be a plural version of the class name
                    let expectedComicSection = SummarySection(
                        name: "Comics", summaries: [mockComic]
                    )
                    
                    let comicSection = HeroDetailViewController.parsed(summaryList: hero.comics)
                    
                    expect(comicSection.name).to(equal(expectedComicSection.name))
                    
                    var i: Int = 0
                    _ = comicSection.summaries?.map { summary in
                        
                        let expectedSummary = expectedComicSection.summaries?[i]
                        
                        expect(summary.name).to(equal(expectedSummary?.name))
                        expect(summary.resourceURI).to(equal(expectedSummary?.resourceURI))
                        i = i + 1
                    }
                }
            }
            
            context("the aggregated function") {
                it("returns the array of parsed SummarySection") {
                    
                    let expectedComicSection = SummarySection(
                        name: "Comics", summaries: [mockComic]
                    )
                    
                    let expectedEventSection = SummarySection(
                        name: "Events", summaries: [mockEvent]
                    )
                    
                    let expectedStorySection = SummarySection(
                        name: "Stories", summaries: [mockStory]
                    )
                    
                    let expectedSeriesSection = SummarySection(
                        name: "Series", summaries: [mockSeries]
                    )
                    
                    let expectedList: [SummarySection] = [
                        expectedComicSection, expectedEventSection, expectedStorySection, expectedSeriesSection
                    ]
                    
                    let summaries: [[Summary]?] = [hero.comics, hero.events, hero.stories, hero.series]
                    
                    let list = HeroDetailViewController.aggregated(list: summaries)
                    
                    var i: Int = 0
                    _ = list.map { section in
                        
                        let expectedSection = expectedList[i]
                        
                        expect(section.name).to(equal(expectedSection.name))
                        expect(section.summaries?.count).to(equal(expectedSection.summaries?.count))
                        
                        var j: Int = 0
                        _ = section.summaries?.map { summary in
                            
                            let expectedSummary = expectedSection.summaries?[j]
                            
                            expect(summary.name).to(equal(expectedSummary?.name))
                            expect(summary.resourceURI).to(equal(expectedSummary?.resourceURI))
                            j = j + 1
                        }
                        
                        i = i + 1
                    }
                }
            }
        }
    }
}
