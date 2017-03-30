/*
 This is free and unencumbered software released into the public domain.
 
 Anyone is free to copy, modify, publish, use, compile, sell, or
 distribute this software, either in source code form or as a compiled
 binary, for any purpose, commercial or non-commercial, and by any
 means.
 
 In jurisdictions that recognize copyright laws, the author or authors
 of this software dedicate any and all copyright interest in the
 software to the public domain. We make this dedication for the benefit
 of the public at large and to the detriment of our heirs and
 successors. We intend this dedication to be an overt act of
 relinquishment in perpetuity of all present and future rights to this
 software under copyright law.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
 OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
 ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 
 For more information, please refer to <http://unlicense.org>
*/

#import "ViewController.h"

NSString *const SQLiteDataCell = @"SQLiteDataCell";

@interface ViewController ()

@end

@implementation ViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        LabQLiteDatabaseController *dbController = [LabQLiteDatabaseController sharedDatabaseController];
        NSError *error;
        _firstTenGardens = nil;
        _firstTenGardens = [dbController rowsFromTable:@"garden"
                                  withSpecifiedColumns:nil
                                          stipulations:nil
                                                offset:0
                            andMaxNumberOfRowsToReturn:10
                                             orderedBy:nil
                                                 error:&error];
        if (!_firstTenGardens) {
            NSLog(@"Could not initialize array of gardens. Error: %@", error);
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Gardens";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:SQLiteDataCell];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_firstTenGardens count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SQLiteDataCell];
    NSInteger i = indexPath.row;
    
    // Get object at index i from the array of gardens
    NSArray *rowObject = (NSArray *)[_firstTenGardens objectAtIndex:i];
    
    // Get garden name.
    NSString *gardenName = (NSString *)[rowObject objectAtIndex:0];
    
    cell.textLabel.text = gardenName;
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
