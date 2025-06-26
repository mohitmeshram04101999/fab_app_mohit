
class MyUrl {
  // static String base = 'https://api.opebo.in/api/';
  static String base = 'https://apifab.loader.co.in/api/';
  static String login = 'user/login';
  static String verifyOtp = 'user/verifyOtp';
  static String getUser = 'user/getUserById';
  static String getAuthUrl = 'auth-url';
  static String updateProfile = 'user/updateUser';
  static String bucketUrl = 'https://leadkart.in-maa-1.linodeobjects.com/';
  static String getAllBusiness = 'getAllBusiness';
  static String getAiReply = 'generate-haiku';
  static String createProduct = 'createProduct';
  static String getCompany = 'getCompany';
  static String getPlan = 'filterPlan';
  static String purchasePlan = 'createPurchasePlan';

  static String getBusinessById ({
    required final String businessId,
}){
    return 'getBuinessById?businessId=67f36b9148b4a8ae15b17aa7';
  }


  static String getAllProduct ({
    required final String businessId,
  }){
    return 'getAllProducts?businessId=$businessId';
  }

  static String getHomeScreenData = 'getDashboardMetrics?businessId=';
  static String getMoreCompetitor = 'moreCompetitor';
  static String moreKeyWords({required final String businessId})
  {
    return 'moreKeywords?businessId=$businessId';
  }

  static String deleteProduct({required final String gmbProductId})
  {
    return 'deleteProduct?gmbProductId=$gmbProductId';
  }

  static String deleteKeyForSeo({
    required final String keyId,
    required final String businessId,
  })
  {
    return 'deleteKeyword?primaryKeywordForSEOId=$keyId&businessId=$businessId';
  }

  static String deleteAdditionalCategory({
    required final String catId,
    required final String businessId,
  })
  {
    return 'deleteAdditionalKeyword?AdditionalKeywordId=$catId&businessId=$businessId';
  }

  static String updateProduct({required final String gmbProductId})
  {
    return 'updateProduct?gmbProductId=$gmbProductId';
  }




  //
//
//
//
  static String getAllPost ({
    required final String businessId,
  }){
    return 'getAllPosts?businessId=$businessId';
  }

  static String createPost ({
    required final String gToken,
  }){
    return 'createPost?accessToken=$gToken';
  }

  static String updatePost ({
    required final String gbmPostId,
    required final String businessId,
    required final String googleToken
  }){
    return 'updatePost?accessToken=$googleToken&businessId=$businessId&gmbPostId=$gbmPostId';
  }

  static String deletePost ({
    required final String gbmPostId,
    required final String businessId,
    required final String googleToken
  }){
    return 'deletePost?accessToken=$googleToken&businessId=$businessId&gmbPostId=$gbmPostId';
  }



  //Media apis path
  static String getAllMedia ({
    required final String businessId,
  }){
    return 'getAllMedia?businessId=$businessId';
  }

  static String createMedia ({
    required final String gToken,
  }){
    return 'createMedia?accessToken=$gToken';
  }

  static String deleteMedia ({
    required final String gbmPostId,
    required final String businessId,
    required final String googleToken
  }){
    return 'deleteMedia?accessToken=$googleToken&businessId=$businessId&gmbMediaId=$gbmPostId';
  }


  static String editBusiness ({
    required final String businessId,
    required final String googleToken
  }){
    return 'updateBusiness?accessToken=$googleToken&businessId=$businessId';
  }


  //------- Service
  static String getAllService ({
    required final String businessId,
  }){
    return 'getAllServices?businessId=$businessId';
  }

  static String createService ({
    required final String gToken,
  }){
    return 'addService?accessToken=$gToken';
  }

  static String deleteService ({
    required final String gbmPostId,
    required final String businessId,
    required final String googleToken
  }){
    return 'removeService?accessToken=$googleToken&businessId=$businessId&serviceId=$gbmPostId';
  }

  static String getGoogleReport ({
    required final String businessId,
  }){
    return 'detailedReport?businessId=$businessId';
  }



  //

  static String getAllReview ({
    required final String businessId,

  }){
    return 'getAllReviews?businessId=$businessId';
  }

  static String upDateReview ({
    required final String businessId,
    required final String gToken,

  }){
    return 'updateReview?businessId=$businessId&accessToken=$gToken';
  }

  static String deleteReview ({
    required final String businessId,
    required final String gToken,
    required final String reviewId,

  }){
    return 'deleteReview?businessId=$businessId&accessToken=$gToken&reviewId=$reviewId';
  }


  static String getNotification ({
    required final String userId,

  }){
    return 'getNotificationByUserId?userId=$userId';
  }

  static String getNotificationCount ({
    required final String userId,

  }){
    return 'notificationCount?userId=$userId';
  }




}