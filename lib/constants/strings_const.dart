class Strings {
  Strings._();

  //General
  static const String appName = "Pixabay Flutter demo";

  //Splash
  static const String website = "pixabay.com";

  //Home
  static const String downloadText = "Download";
  static const String addFavouritesText = "Add to your favourites.";
  static const String enterSearchText = "Enter search text here..";
  static const String searchText = "Search";

  //How To Use
  static const String goBackText = "Go back";

  //Search
  static const String noResults = "Your search returned no results.";
  static const String searchHint = "Enter search query here.";

  //Detail Page
  static const String commentsText = "Comments";
  static const String downloadsText = "Downloads";
  static const String likesText = "Likes";
  static const String downloadProfilePictureText = "Profile Picture";
  static const String addToFavouriteText = "Add to favourite";
  static const String removeFromFavouriteText = "Remove from favourite";
  static const String favouritesText = "Favourites";
  static const String viewAdText =
      "";
  static const String okText = "Ok";
  static const String cancelText = "Cancel";
  static const String downloadedText = "Downloaded";
  static const String progressText = "Progress:";

  static const String API_KEY = "11990318-dcf17d26f79864dd1e5099fba";

  //Base URL
  static const SEARCH_URL = "https://pixabay.com/api/?key=${API_KEY}&image_type=photo&pretty=true&q=";
  static const SEARCH_VIDEOS_URL = "https://pixabay.com/api/videos/?key=${API_KEY}&image_type=photo&pretty=true&q=";
  static const FETCH_USER_DETAILS_URL =
      "https://savestorie.com/api/loadCompteInsta/";
  static const FETCH_USER_STORIES_URL =
      "https://savestorie.com/api/loadStories/";

  //Errors
  static const String noInternet = "You are not connected to Internet!";
}
