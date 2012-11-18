# Network code example for the 3rd homework

Note: this project demonstrates multipart-http request for image uploading. You are advised to use that code + adjust `Item` model, its properties, `initWithJSONObject:` and `JSONObject` methods.

Warning: some values are hardcoded such as `items/4`.

## `NetworkService.h`

	(void)createFriend:(Item *)item success:(void (^)(Item *item))onSuccess failure:(void (^)())onFailure;

creates a new friend

	(void)updateFriend:(Item *)item withImage:(UIImage *)anImage success:(void (^)(Item *item))onSuccess failure:(void (^)())onFailure;
	
the current implementation updated the image ONLY, use the regular PUT to update normal properties (such as Name, status, latitude, longitude and gender) or update this method (not recommended as it might be time consuming and frustrating).