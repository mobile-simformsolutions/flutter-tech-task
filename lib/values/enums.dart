/// Represents the network state for api calls
enum NetworkState {
  /// when the api call is ongoing
  loading,

  /// when the api call succeeds
  success,

  /// when the api call fails
  failure,
}
