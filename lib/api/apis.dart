class Apis{

  //Base url
  static const String baseURL = "http://fastfillpro.developitech.com/api/";

  //  LOGIN
  static const String login = "Login";

  //  USER
  static const String user = "User";
  static const String updateUser = "User/UpdateUser";
  static const String insertUser = "User/Insert";
  static const String getUsers = "User/users";
  static const String getAdministrators = "User/admins";
  static const String getCompaniesUsers = "User/CompaniesUsers";
  static const String updateUserProfile = "User/UpdateUserProfile";
  static const String updateFirebaseToken = "User/UpdateFirebaseToken";
  static const String addNotification = "User/AddNotification";
  static const String getNotifications = "User/GetNotifications";
  static const String addPaymentTransaction = "User/AddPaymentTransaction";
  static const String getPaymentTransactions = "User/GetPaymentTransactions";
  static const String uploadProfilePhoto = "User/UploadLogo";

  static const String topUpCredit = "User/CreditFromAdmin";

  // Stations
  static const String station = "station";

  //Companies
  static const String company = "Company";
  static const String allCompanies = "Company/AllCompanies";
  static const String companyByCode = "Company/CompanyByCode/{code}";
  static const String companiesByName = "Company/CompaniesByName/{name}";
  static const String allCompanyBranches = "Company/AllCompaniesBranches";
  static const String companyBranches = "Company/CompanyBranches";
  static const String companyBranchByCode = "Company/CompaniesBranchesByText";
  static const String companiesByText = "Company/CompaniesBranchesByText";
  static const String companyBranchesByAddress = "Company/CompanyBranchesByAddress";
  static const String addCompanyToFavorite = "Company/AddToFavorite";
  static const String removeCompanyFromFavorite = "Company/RemoveFromFavorite";
  static const String favoriteCompaniesBranches = "Company/FavoriteCompaniesBranches";
  static const String frequentlyVisitedCompaniesBranches = "Company/FrequentlyVisitedCompaniesBranches";
  static const String addCompanyBranchToFavorite = "Company/AddBranchToFavorite";
  static const String removeCompanyBranchFromFavorite = "Company/RemoveBranchFromFavorite";

  static const String insertCompany = "Company/InsertCompany";
  static const String updateCompany = "Company/UpdateCompany";
  static const String deleteCompany = "Company/DeleteCompany";

  static const String insertCompanyBranch = "Company/InsertCompanyBranch";
  static const String updateCompanyBranch = "Company/UpdateCompanyBranch";
  static const String deleteCompanyBranch = "Company/DeleteCompanyBranch";
  static const String getDashboardData = "Dashboard/DashboardData";

  static const String getRefills = "Dashboard/GetRefills";
  static const String getPaymentTransactionResults = "Dashboard/GetPaymentTransactionResults";

  static const String sendCustomNotification = "User/SendCustomNotification";
  static const String sendCustomNotificationToAll = "User/SendCustomNotificationToAll";
  static const String sendCustomNotificationToMultiple = "User/SendCustomNotificationToMultiple";

  static const String getUserByMobileNumber = "User/ByPhone/{mobileNumber}/{roleId}";
  static const String getUserById = "User/{id}/{roleId}";


  static const String insertGroup = "Company/InsertGroup";
  static const String updateGroup = "Company/UpdateGroup";
  static const String deleteGroup = "Company/DeleteGroup";
  static const String allGroups = "Company/AllGroups";
  static const String groupsByName = "Company/GroupsByName/{name}";

}
