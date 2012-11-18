/*
 blockSelf
 */

#define DEFINE_BLOCK_SELF       __weak __typeof__(self) blockSelf = self

/*
 GCD Singleton
 */

#define DEFINE_SHARED_INSTANCE_USING_BLOCK(block) \
static dispatch_once_t pred = 0; \
__strong static id _sharedObject = nil; \
dispatch_once(&pred, ^{ \
_sharedObject = block(); \
}); \
\
return _sharedObject;

/*
 Asserts
 */

#define ASSERT_MAIN_THREAD     NSAssert([[NSThread currentThread] isMainThread], @"This method must be called on the main thread.")

/*
 Logging
 */

#ifdef DEBUG
#define TRC_ENTRY    NSLog(@"ENTRY: %s:%d", __PRETTY_FUNCTION__, __LINE__)
#define TRC_EXIT     NSLog(@"EXIT : %s:%d", __PRETTY_FUNCTION__, __LINE__)
#else
#define TRC_ENTRY
#define TRC_EXIT
#endif

#ifdef DEBUG
#define TRC_POINT(A)    NSLog(@"POINT: %f, %f", A.x, A.y)
#define TRC_SIZE(A)     NSLog(@"SIZE: %f, %f", A.width, A.height)
#define TRC_RECT(A)     NSLog(@"RECT: %f, %f, %f, %f", A.origin.x, A.origin.y, A.size.width, A.size.height)
#else
#define TRC_POINT(A)
#define TRC_SIZE(A)
#define TRC_RECT(A)
#endif

#ifdef DEBUG
#define TRC_STR(A)              NSLog(@"%@", A)
#define TRC_OBJ(A)              NSLog(@"%@", [A description])
#define TRC_LOG(format, ...)    NSLog(format, ## __VA_ARGS__)
#define TRC_ERR(format, ...)    NSLog(@"error: %@, %s:%d " format, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __FUNCTION__, __LINE__, ## __VA_ARGS__)
#else
#define TRC_STR(A)
#define TRC_OBJ(A)
#define TRC_LOG(format, ...)
#define TRC_ERR(format, ...)    NSLog(@"error: %@, %s:%d " format, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __FUNCTION__, __LINE__, ## __VA_ARGS__)
#endif

#ifdef DEBUG
#define TRC_DATA(A)    NSLog(@"DATA %10db: %@", [A length], [[NSString alloc] initWithData:A encoding:NSUTF8StringEncoding])
#else
#define TRC_DATA(A)
#endif