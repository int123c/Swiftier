//
//  SwiftierTests.m
//  SwiftierTests
//
//  Created by int123c on 09/08/2017.
//  Copyright (c) 2017 int123c. All rights reserved.
//

@import XCTest;
@import Swiftier;

@interface Tests : XCTestCase

@end

@implementation Tests

- (void)testNSArrayMap {
    let array = @[@1,@2,@3];
    NSArray<NSNumber *> *new = [array swt_map:^NSNumber*(NSNumber* obj){
        return @(obj.intValue + 1);
    }];
    
    XCTAssertEqual(new[0].intValue, 2);
    XCTAssertEqual(new[1].intValue, 3);
    XCTAssertEqual(new[2].intValue, 4);
}

- (void)testNSArrayFlatMap {
    let array = @[@1,[NSNull null],@3];
    NSArray<NSNumber *> *new = [array swt_compactMap:^NSNumber*(NSNumber* obj){
        return @(obj.intValue + 1);
    }];
    
    XCTAssertEqual(new[0].intValue, 2);
    XCTAssertEqual(new[1].intValue, 4);
}

- (void)testNSArrayFilter {
    let array = @[@1,@2,@3];
    NSArray<NSNumber *> *new = [array swt_filter:^BOOL (NSNumber* obj){
        return obj.intValue > 1;
    }];
    
    XCTAssertEqual(new[0].intValue, 2);
    XCTAssertEqual(new[1].intValue, 3);
}

- (void)testNSArrayFirstWhere {
    let array = @[@1,@2,@3,@4,@5];
    NSNumber * shouldBe2 = [array swt_firstWhere:^BOOL (NSNumber *obj){
        return obj.integerValue >= 2;
    }];
    NSNumber * shouldBe4 = [array swt_firstWhere:^BOOL (NSNumber *obj){
        return obj.integerValue >= 4;
    }];
    NSNumber * shouldBeNil = [array swt_firstWhere:^BOOL (NSNumber *obj){
        return obj.integerValue >= 10;
    }];
    
    XCTAssertEqual(shouldBe2.integerValue, 2);
    XCTAssertEqual(shouldBe4.integerValue, 4);
    XCTAssertNil(shouldBeNil);
}

- (void)testNSMutableArrayMap {
    let array = [[NSMutableArray alloc] initWithObjects:@1, @2, @3, nil];
    NSArray<NSNumber *> *new = [array swt_map:^NSNumber*(NSNumber* obj){
        return @(obj.intValue + 1);
    }];
    
    XCTAssertEqual(new[0].intValue, 2);
    XCTAssertEqual(new[1].intValue, 3);
    XCTAssertEqual(new[2].intValue, 4);
}

- (void)testNSMutableArrayFlatMap {
    let array = [[NSMutableArray alloc] initWithObjects:@1, [NSNull null], @3, nil];
    NSArray<NSNumber *> *new = [array swt_compactMap:^NSNumber*(NSNumber* obj){
        return @(obj.intValue + 1);
    }];
    
    XCTAssertEqual(new[0].intValue, 2);
    XCTAssertEqual(new[1].intValue, 4);
}

- (void)testNSMutableArrayFilter {
    let array = @[@1,@2,@3].mutableCopy;
    NSArray<NSNumber *> *new = [array swt_filter:^BOOL (NSNumber* obj){
        return obj.intValue > 1;
    }];
    
    XCTAssertEqual(new[0].intValue, 2);
    XCTAssertEqual(new[1].intValue, 3);
}

- (void)testNSMutableArrayFirstWhere {
    let array = @[@1,@2,@3,@4,@5].mutableCopy;
    NSNumber * shouldBe2 = [array swt_firstWhere:^BOOL (NSNumber *obj){
        return obj.integerValue >= 2;
    }];
    NSNumber * shouldBe4 = [array swt_firstWhere:^BOOL (NSNumber *obj){
        return obj.integerValue >= 4;
    }];
    NSNumber * shouldBeNil = [array swt_firstWhere:^BOOL (NSNumber *obj){
        return obj.integerValue >= 10;
    }];
    
    XCTAssertEqual(shouldBe2.integerValue, 2);
    XCTAssertEqual(shouldBe4.integerValue, 4);
    XCTAssertNil(shouldBeNil);
}

@end

@interface DeferTests : XCTestCase

@property (nonatomic) BOOL deferCalled;

@end

@implementation DeferTests

- (void)setUp {
    [super setUp];
    self.deferCalled = NO;
}

- (void)tearDown {
    XCTAssertTrue(self.deferCalled);
    [super tearDown];
}

- (void)testDefer {
    swt_defer { self.deferCalled = YES; };
    XCTAssertFalse(self.deferCalled);
}

@end
