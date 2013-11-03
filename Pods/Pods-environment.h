
// To check if a library is compiled with CocoaPods you
// can use the `COCOAPODS` macro definition which is
// defined in the xcconfigs so it is available in
// headers also when they are imported in the client
// project.


// AFNetworking
#define COCOAPODS_POD_AVAILABLE_AFNetworking
#define COCOAPODS_VERSION_MAJOR_AFNetworking 1
#define COCOAPODS_VERSION_MINOR_AFNetworking 3
#define COCOAPODS_VERSION_PATCH_AFNetworking 3

// Backbeam
#define COCOAPODS_POD_AVAILABLE_Backbeam
#define COCOAPODS_VERSION_MAJOR_Backbeam 0
#define COCOAPODS_VERSION_MINOR_Backbeam 10
#define COCOAPODS_VERSION_PATCH_Backbeam 13

// SocketRocket
#define COCOAPODS_POD_AVAILABLE_SocketRocket
#define COCOAPODS_VERSION_MAJOR_SocketRocket 0
#define COCOAPODS_VERSION_MINOR_SocketRocket 3
#define COCOAPODS_VERSION_PATCH_SocketRocket 1

// socket.IO
#define COCOAPODS_POD_AVAILABLE_socket_IO
// This library does not follow semantic-versioning,
// so we were not able to define version macros.
// Please contact the author.
// Version: 0.4.0.1.

