#import "BroadcastDate.h"
#import "Episode.h"
#include <HTTPRiot/HTTPRiot.h>

@implementation BroadcastDate

@synthesize date;
@synthesize episodes;

+ (void)initialize {
  [self setDelegate:self];
  [self setBaseURL:[NSURL URLWithString:@"http://itrakt.matsimitsu.com"]];
}

- (id)initWithDictionary:(NSDictionary *)dict delegate:(id)delegate {
    if(self = [super init]) {
      NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
      dateFormatter.dateFormat = @"yyyy-mm-dd";
      self.date = [dateFormatter dateFromString:[dict valueForKeyPath:@"date"]];

      NSMutableArray *objectifiedEpisodes = [[[NSMutableArray alloc] init] autorelease];

      for(id episode in [dict valueForKeyPath:@"episodes"]) {
        [objectifiedEpisodes addObject:[[Episode alloc] initWithDictionary:episode broadcastDate:self delegate:delegate]];
      }

      self.episodes = objectifiedEpisodes;
    }

    return self;
}


+ (void)restConnection:(NSURLConnection *)connection didReturnResource:(id)resource  object:(id)object {
    NSMutableArray *dates = [[[NSMutableArray alloc] init] autorelease];

    for(id item in resource) {
      [dates addObject:[[BroadcastDate alloc] initWithDictionary:item delegate:object]];
    }

    NSLog(@"[!] Finished download of calendar data");
    // Let the tableview know we have new dates
    [object performSelector:@selector(datesLoaded:) withObject:dates];
}

+ (id)getDates:(id)object {
  NSLog(@"[!] Start download of calendar data");
  return [self getPath:@"/users/calendar.json?name=matsimitsu" withOptions:nil object:object];
}


@end
